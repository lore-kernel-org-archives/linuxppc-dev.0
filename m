Return-Path: <neelegup@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 327781A075F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2015 18:43:10 +1000 (AEST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <neelegup@linux.vnet.ibm.com>;
 Fri, 17 Jul 2015 18:43:09 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id A3C892BB0040
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2015 18:43:06 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6H8gw7K61014210
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2015 18:43:06 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6H8gXm5004600
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2015 18:42:34 +1000
Message-ID: <55A8BFDF.2020601@linux.vnet.ibm.com>
Date: Fri, 17 Jul 2015 14:12:07 +0530
From: Neelesh Gupta <neelegup@linux.vnet.ibm.com>
MIME-Version: 1.0
To: minyard@acm.org, alistair@popple.id.au, linuxppc-dev@lists.ozlabs.org,
 jk@ozlabs.org
Subject: Re: [PATCH] ipmi/powernv: Fix potential invalid pointer dereference
References: <20150716111628.28037.80799.stgit@localhost.localdomain>
 <55A7C747.1050509@acm.org>
In-Reply-To: <55A7C747.1050509@acm.org>
Content-Type: multipart/alternative;
 boundary="------------040805040104020505050604"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------040805040104020505050604
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Corey,

On 07/16/2015 08:31 PM, Corey Minyard wrote:
> Ok, this looks fine.  A couple of question...
>
> Do I need to send this upstream right now?  How well has this been tested?

I would want either Jeremy or Alistair to review this patch before you 
send this
upstream. There is also firmware piece 
http://patchwork.ozlabs.org/patch/496645/
awaiting review.

In the testing front, I manually made the opal_ipmi_recv() function to 
fail for testing
the error path and see if the driver recovers from it and subsequent 
ipmi commands
work all good.

>
> Do you want this backported to 4.0 stable?

Yes, I want this to be be backported to 4.0 stable.

Thanks,
Neelesh.

>
> -corey
>
> On 07/16/2015 06:16 AM, Neelesh Gupta wrote:
>> If the OPAL call to receive the ipmi message fails, then we free up the
>> smi message and return. But, the driver still holds the reference to
>> old smi message in the 'cur_msg' which can potentially be accessed later
>> and freed again leading to kernel oops. To fix it up,
>>
>> The kernel driver should reset the 'cur_msg' and send reply to the user
>> in addition to freeing the message.
>>
>> Signed-off-by: Neelesh Gupta <neelegup@linux.vnet.ibm.com>
>> ---
>>   drivers/char/ipmi/ipmi_powernv.c |   13 ++++++++++---
>>   1 file changed, 10 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/char/ipmi/ipmi_powernv.c b/drivers/char/ipmi/ipmi_powernv.c
>> index 9b409c0..637486d 100644
>> --- a/drivers/char/ipmi/ipmi_powernv.c
>> +++ b/drivers/char/ipmi/ipmi_powernv.c
>> @@ -143,9 +143,16 @@ static int ipmi_powernv_recv(struct ipmi_smi_powernv *smi)
>>   	pr_devel("%s:   -> %d (size %lld)\n", __func__,
>>   			rc, rc == 0 ? size : 0);
>>   	if (rc) {
>> -		spin_unlock_irqrestore(&smi->msg_lock, flags);
>> -		ipmi_free_smi_msg(msg);
>> -		return 0;
>> +		/* If came via the poll, and response was not yet ready */
>> +		if (rc == OPAL_EMPTY) {
>> +			spin_unlock_irqrestore(&smi->msg_lock, flags);
>> +			return 0;
>> +		} else {
>> +			smi->cur_msg = NULL;
>> +			spin_unlock_irqrestore(&smi->msg_lock, flags);
>> +			send_error_reply(smi, msg, IPMI_ERR_UNSPECIFIED);
>> +			return 0;
>> +		}
>>   	}
>>   
>>   	if (size < sizeof(*opal_msg)) {
>>


--------------040805040104020505050604
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <small>Hi Corey,</small><br>
    <br>
    <div class="moz-cite-prefix">On 07/16/2015 08:31 PM, Corey Minyard
      wrote:<br>
    </div>
    <blockquote cite="mid:55A7C747.1050509@acm.org" type="cite">
      <pre wrap="">Ok, this looks fine.  A couple of question...

Do I need to send this upstream right now?  How well has this been tested?</pre>
    </blockquote>
    <br>
    <small>I would want either Jeremy or Alistair to review this patch
      before you send this<br>
      upstream. There is also firmware piece
      <a class="moz-txt-link-freetext" href="http://patchwork.ozlabs.org/patch/496645/">http://patchwork.ozlabs.org/patch/496645/</a><br>
      awaiting review.<br>
      <br>
      In the testing front, I manually made the opal_ipmi_recv()
      function to fail for testing<br>
      the error path and see if the driver recovers from it and
      subsequent ipmi commands<br>
      work all good.<br>
    </small><br>
    <blockquote cite="mid:55A7C747.1050509@acm.org" type="cite">
      <pre wrap="">

Do you want this backported to 4.0 stable?</pre>
    </blockquote>
    <br>
    <small>Yes, I want this to be be backported to 4.0 stable.<br>
      <br>
      Thanks,<br>
      Neelesh.<br>
    </small><br>
    <blockquote cite="mid:55A7C747.1050509@acm.org" type="cite">
      <pre wrap="">

-corey

On 07/16/2015 06:16 AM, Neelesh Gupta wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="">If the OPAL call to receive the ipmi message fails, then we free up the
smi message and return. But, the driver still holds the reference to
old smi message in the 'cur_msg' which can potentially be accessed later
and freed again leading to kernel oops. To fix it up,

The kernel driver should reset the 'cur_msg' and send reply to the user
in addition to freeing the message.

Signed-off-by: Neelesh Gupta <a class="moz-txt-link-rfc2396E" href="mailto:neelegup@linux.vnet.ibm.com">&lt;neelegup@linux.vnet.ibm.com&gt;</a>
---
 drivers/char/ipmi/ipmi_powernv.c |   13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_powernv.c b/drivers/char/ipmi/ipmi_powernv.c
index 9b409c0..637486d 100644
--- a/drivers/char/ipmi/ipmi_powernv.c
+++ b/drivers/char/ipmi/ipmi_powernv.c
@@ -143,9 +143,16 @@ static int ipmi_powernv_recv(struct ipmi_smi_powernv *smi)
 	pr_devel("%s:   -&gt; %d (size %lld)\n", __func__,
 			rc, rc == 0 ? size : 0);
 	if (rc) {
-		spin_unlock_irqrestore(&amp;smi-&gt;msg_lock, flags);
-		ipmi_free_smi_msg(msg);
-		return 0;
+		/* If came via the poll, and response was not yet ready */
+		if (rc == OPAL_EMPTY) {
+			spin_unlock_irqrestore(&amp;smi-&gt;msg_lock, flags);
+			return 0;
+		} else {
+			smi-&gt;cur_msg = NULL;
+			spin_unlock_irqrestore(&amp;smi-&gt;msg_lock, flags);
+			send_error_reply(smi, msg, IPMI_ERR_UNSPECIFIED);
+			return 0;
+		}
 	}
 
 	if (size &lt; sizeof(*opal_msg)) {

</pre>
      </blockquote>
      <pre wrap="">
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------040805040104020505050604--
