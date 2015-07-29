Return-Path: <neelegup@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E0C771A0065
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2015 16:09:34 +1000 (AEST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <neelegup@linux.vnet.ibm.com>;
 Wed, 29 Jul 2015 11:39:32 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 74F683940233
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2015 11:36:37 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6T65qi123658618
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2015 11:35:52 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6T65oJe003109
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2015 11:35:50 +0530
Message-ID: <55B86D36.9070507@linux.vnet.ibm.com>
Date: Wed, 29 Jul 2015 11:35:42 +0530
From: Neelesh Gupta <neelegup@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Alistair Popple <alistair@popple.id.au>
CC: jk@ozlabs.org, linuxppc-dev@lists.ozlabs.org, minyard@acm.org
Subject: Re: [PATCH] ipmi/powernv: Fix potential invalid pointer dereference
References: <20150716111628.28037.80799.stgit@localhost.localdomain>
 <55A8BFDF.2020601@linux.vnet.ibm.com> <55B7342F.8080703@linux.vnet.ibm.com>
 <2100038.nvIKqFquOH@mexican>
In-Reply-To: <2100038.nvIKqFquOH@mexican>
Content-Type: multipart/alternative;
 boundary="------------060309040402070300020408"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------060309040402070300020408
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

Hi Alistair,

Thanks for the review.

On 07/28/2015 11:21 PM, Alistair Popple wrote:
> Hi Neelesh,
>
> This fix looks reasonable to me, although Jeremy would be the best person to
> comment if he has time. I wonder why we bother polling at all given that our
> event interface should call opal_ipmi_recv() whenever a message is ready?

Agree. I thought about it and didn't find any reason to have it as we 
have event
mechanism.. but didn't think of changing as it is not causing any issue..

>
> Also the firmware fix you refer to and this fix are independent of each other
> so there's no ordering issues there.

Correct. Though, there is no relation, but I figured out the skiboot 
issue after
this change.. yes, they are independent. Please find time to review the
skiboot patch.

Corey,

Please queue this patch for upstream if you Ok with it.

Thanks,
Neelesh.

>
> Reviewed-By: Alistair Popple <alistair@popple.id.au>
>
> On Tue, 28 Jul 2015 13:20:07 Neelesh Gupta wrote:
>> On 07/17/2015 02:12 PM, Neelesh Gupta wrote:
>>> Hi Corey,
>>>
>>> On 07/16/2015 08:31 PM, Corey Minyard wrote:
>>>> Ok, this looks fine.  A couple of question...
>>>>
>>>> Do I need to send this upstream right now?  How well has this been
> tested?
>>> I would want either Jeremy or Alistair to review this patch before you
>>> send this
>>> upstream. There is also firmware piece
>>> http://patchwork.ozlabs.org/patch/496645/
>>> awaiting review.
>>>
>>> In the testing front, I manually made the opal_ipmi_recv() function to
>>> fail for testing
>>> the error path and see if the driver recovers from it and subsequent
>>> ipmi commands
>>> work all good.
>> Hi Jeremy/Alistair,
>>
>> Could you please review it and the corresponding skiboot patch...
>>
>> Thanks,
>> Neelesh.
>>
>>>> Do you want this backported to 4.0 stable?
>>> Yes, I want this to be be backported to 4.0 stable.
>>>
>>> Thanks,
>>> Neelesh.
>>>
>>>> -corey
>>>>
>>>> On 07/16/2015 06:16 AM, Neelesh Gupta wrote:
>>>>> If the OPAL call to receive the ipmi message fails, then we free up the
>>>>> smi message and return. But, the driver still holds the reference to
>>>>> old smi message in the 'cur_msg' which can potentially be accessed later
>>>>> and freed again leading to kernel oops. To fix it up,
>>>>>
>>>>> The kernel driver should reset the 'cur_msg' and send reply to the user
>>>>> in addition to freeing the message.
>>>>>
>>>>> Signed-off-by: Neelesh Gupta<neelegup@linux.vnet.ibm.com>
>>>>> ---
>>>>>    drivers/char/ipmi/ipmi_powernv.c |   13 ++++++++++---
>>>>>    1 file changed, 10 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/drivers/char/ipmi/ipmi_powernv.c
> b/drivers/char/ipmi/ipmi_powernv.c
>>>>> index 9b409c0..637486d 100644
>>>>> --- a/drivers/char/ipmi/ipmi_powernv.c
>>>>> +++ b/drivers/char/ipmi/ipmi_powernv.c
>>>>> @@ -143,9 +143,16 @@ static int ipmi_powernv_recv(struct
> ipmi_smi_powernv *smi)
>>>>>    	pr_devel("%s:   -> %d (size %lld)\n", __func__,
>>>>>    			rc, rc == 0 ? size : 0);
>>>>>    	if (rc) {
>>>>> -		spin_unlock_irqrestore(&smi->msg_lock, flags);
>>>>> -		ipmi_free_smi_msg(msg);
>>>>> -		return 0;
>>>>> +		/* If came via the poll, and response was not yet ready */
>>>>> +		if (rc == OPAL_EMPTY) {
>>>>> +			spin_unlock_irqrestore(&smi->msg_lock, flags);
>>>>> +			return 0;
>>>>> +		} else {
>>>>> +			smi->cur_msg = NULL;
>>>>> +			spin_unlock_irqrestore(&smi->msg_lock, flags);
>>>>> +			send_error_reply(smi, msg, IPMI_ERR_UNSPECIFIED);
>>>>> +			return 0;
>>>>> +		}
>>>>>    	}
>>>>>
>>>>>    	if (size < sizeof(*opal_msg)) {
>>>>>
>>>
>>>
>>> _______________________________________________
>>> Linuxppc-dev mailing list
>>> Linuxppc-dev@lists.ozlabs.org
>>> https://lists.ozlabs.org/listinfo/linuxppc-dev


--------------060309040402070300020408
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=windows-1252"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <small>Hi Alistair,<br>
      <br>
      Thanks for the review.<br>
    </small><br>
    <div class="moz-cite-prefix">On 07/28/2015 11:21 PM, Alistair Popple
      wrote:<br>
    </div>
    <blockquote cite="mid:2100038.nvIKqFquOH@mexican" type="cite">
      <pre wrap="">Hi Neelesh,

This fix looks reasonable to me, although Jeremy would be the best person to 
comment if he has time. I wonder why we bother polling at all given that our 
event interface should call opal_ipmi_recv() whenever a message is ready?</pre>
    </blockquote>
    <br>
    <small>Agree. I thought about it and didn't find any reason to have
      it as we have event<br>
      mechanism.. but didn't think of changing as it is not causing any
      issue..</small><br>
    <br>
    <blockquote cite="mid:2100038.nvIKqFquOH@mexican" type="cite">
      <pre wrap="">

Also the firmware fix you refer to and this fix are independent of each other 
so there's no ordering issues there.</pre>
    </blockquote>
    <br>
    <small>Correct. Though, there is no relation, but I figured out the
      skiboot issue after<br>
      this change.. yes, they are independent. Please find time to
      review the<br>
      skiboot patch.</small><br>
    <br>
    <small>Corey,<br>
      <br>
      Please queue this patch for upstream if you Ok with it.<br>
      <br>
      Thanks,<br>
      Neelesh.<br>
    </small><br>
    <blockquote cite="mid:2100038.nvIKqFquOH@mexican" type="cite">
      <pre wrap="">

Reviewed-By: Alistair Popple <a class="moz-txt-link-rfc2396E" href="mailto:alistair@popple.id.au">&lt;alistair@popple.id.au&gt;</a>

On Tue, 28 Jul 2015 13:20:07 Neelesh Gupta wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="">
On 07/17/2015 02:12 PM, Neelesh Gupta wrote:
</pre>
        <blockquote type="cite">
          <pre wrap="">Hi Corey,

On 07/16/2015 08:31 PM, Corey Minyard wrote:
</pre>
          <blockquote type="cite">
            <pre wrap="">Ok, this looks fine.  A couple of question...

Do I need to send this upstream right now?  How well has this been 
</pre>
          </blockquote>
        </blockquote>
      </blockquote>
      <pre wrap="">tested?
</pre>
      <blockquote type="cite">
        <blockquote type="cite">
          <pre wrap="">
I would want either Jeremy or Alistair to review this patch before you 
send this
upstream. There is also firmware piece 
<a class="moz-txt-link-freetext" href="http://patchwork.ozlabs.org/patch/496645/">http://patchwork.ozlabs.org/patch/496645/</a>
awaiting review.

In the testing front, I manually made the opal_ipmi_recv() function to 
fail for testing
the error path and see if the driver recovers from it and subsequent 
ipmi commands
work all good.
</pre>
        </blockquote>
        <pre wrap="">
Hi Jeremy/Alistair,

Could you please review it and the corresponding skiboot patch...

Thanks,
Neelesh.

</pre>
        <blockquote type="cite">
          <pre wrap="">
</pre>
          <blockquote type="cite">
            <pre wrap="">Do you want this backported to 4.0 stable?
</pre>
          </blockquote>
          <pre wrap="">
Yes, I want this to be be backported to 4.0 stable.

Thanks,
Neelesh.

</pre>
          <blockquote type="cite">
            <pre wrap="">-corey

On 07/16/2015 06:16 AM, Neelesh Gupta wrote:
</pre>
            <blockquote type="cite">
              <pre wrap="">If the OPAL call to receive the ipmi message fails, then we free up the
smi message and return. But, the driver still holds the reference to
old smi message in the 'cur_msg' which can potentially be accessed later
and freed again leading to kernel oops. To fix it up,

The kernel driver should reset the 'cur_msg' and send reply to the user
in addition to freeing the message.

Signed-off-by: Neelesh Gupta<a class="moz-txt-link-rfc2396E" href="mailto:neelegup@linux.vnet.ibm.com">&lt;neelegup@linux.vnet.ibm.com&gt;</a>
---
  drivers/char/ipmi/ipmi_powernv.c |   13 ++++++++++---
  1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_powernv.c 
</pre>
            </blockquote>
          </blockquote>
        </blockquote>
      </blockquote>
      <pre wrap="">b/drivers/char/ipmi/ipmi_powernv.c
</pre>
      <blockquote type="cite">
        <blockquote type="cite">
          <blockquote type="cite">
            <blockquote type="cite">
              <pre wrap="">index 9b409c0..637486d 100644
--- a/drivers/char/ipmi/ipmi_powernv.c
+++ b/drivers/char/ipmi/ipmi_powernv.c
@@ -143,9 +143,16 @@ static int ipmi_powernv_recv(struct 
</pre>
            </blockquote>
          </blockquote>
        </blockquote>
      </blockquote>
      <pre wrap="">ipmi_smi_powernv *smi)
</pre>
      <blockquote type="cite">
        <blockquote type="cite">
          <blockquote type="cite">
            <blockquote type="cite">
              <pre wrap="">  	pr_devel("%s:   -&gt; %d (size %lld)\n", __func__,
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
          </blockquote>
          <pre wrap="">


_______________________________________________
Linuxppc-dev mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Linuxppc-dev@lists.ozlabs.org">Linuxppc-dev@lists.ozlabs.org</a>
<a class="moz-txt-link-freetext" href="https://lists.ozlabs.org/listinfo/linuxppc-dev">https://lists.ozlabs.org/listinfo/linuxppc-dev</a>
</pre>
        </blockquote>
        <pre wrap="">
</pre>
      </blockquote>
      <pre wrap="">
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------060309040402070300020408--
