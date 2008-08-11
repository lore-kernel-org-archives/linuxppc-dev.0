Return-Path: <sfalco@harris.com>
Received: from mlbe2k1.cs.myharris.net (mlbe2k1.cs.myharris.net
	[137.237.90.88]) by ozlabs.org (Postfix) with ESMTP id 4F754DE4E5
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Aug 2008 02:42:49 +1000 (EST)
Message-ID: <48A06C06.2070503@harris.com>
Date: Mon, 11 Aug 2008 12:42:46 -0400
From: "Steven A. Falco" <sfalco@harris.com>
MIME-Version: 1.0
To: Ben Dooks <ben-linux@fluff.org>
Subject: Re: [PATCH] pata_of_platform: fix no irq handling
References: <48A05152.7020508@harris.com>
	<20080811151913.GA14690@oksana.dev.rtsoft.ru>
	<20080811163648.GI26082@trinity.fluff.org>
In-Reply-To: <20080811163648.GI26082@trinity.fluff.org>
Content-Type: multipart/alternative;
	boundary="------------070500030100010105040908"
Cc: linuxppc-dev@ozlabs.org, Jeff Garzik <jgarzik@pobox.com>,
	linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------070500030100010105040908
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Ben Dooks wrote:
> On Mon, Aug 11, 2008 at 07:19:13PM +0400, Anton Vorontsov wrote:
>   
>> When no irq specified, pata_of_platform fills irq_res with -1,
>> which is wrong to do for two reasons:
>>
>> 1. By definition, 'no irq' should be IRQ 0, not some negative integer;
>>     
>
> interesting, IRQ 0 is actually valid on some ARM systems.
>
>   

It is here too, but I believe most of the code uses a virtualized irq
number, so physical IRQ 0 would presumably get mapped to a non-zero
virtual one.

>> 2. pata_platform checks for irq_res.start > 0, but since irq_res.start
>>    is unsigned type, the check will be true for `-1'.
>>
>> Reported-by: Steven A. Falco <sfalco@harris.com>
>> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
>> ---
>>
>> On Mon, Aug 11, 2008 at 10:48:50AM -0400, Steven A. Falco wrote:
>>     
>>> I think there is a bug in the communications between pata_of_platform
>>> and pata_platform.  I will refer to the master branch of the DENX git
>>> tree, which is roughly v2.6.26.1 at this time.  I am using a Sequoia
>>> board with a PPC440EPx.
>>>
>>> In pata_of_platform, we have:
>>>
>>>     ret = of_irq_to_resource(dn, 0, &irq_res);
>>>     if (ret == NO_IRQ)
>>>         irq_res.start = irq_res.end = -1;
>>>
>>> so if there is no interrupt defined, then start and end are -1. 
>>> However, __pata_platform_probe has:
>>>
>>>     if (irq_res && irq_res->start > 0) {
>>>         irq = irq_res->start;
>>>         irq_flags = irq_res->flags;
>>>     }
>>>
>>> You might think that the (irq_res->start > 0) test will fail, as it
>>> should in this no-irq case.  But, start is a u64, so the -1 actually
>>> looks like a large positive number in the comparison.  So,
>>> __pata_platform_probe attempts to use an interrupt when there isn't one.
>>>
>>> I think the fix would be to change __pata_platform_probe to:
>>>
>>>     if (irq_res && irq_res->start != -1) {
>>>
>>> but that might have other unintended consequences, so I'll defer to
>>> whomever knows more about the intent of this code.
>>>       
>> Something like this patch should work. Thanks for noticing!
>>
>>  drivers/ata/pata_of_platform.c |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/ata/pata_of_platform.c b/drivers/ata/pata_of_platform.c
>> index 408da30..1f18ad9 100644
>> --- a/drivers/ata/pata_of_platform.c
>> +++ b/drivers/ata/pata_of_platform.c
>> @@ -52,7 +52,7 @@ static int __devinit pata_of_platform_probe(struct of_device *ofdev,
>>  
>>  	ret = of_irq_to_resource(dn, 0, &irq_res);
>>  	if (ret == NO_IRQ)
>> -		irq_res.start = irq_res.end = -1;
>> +		irq_res.start = irq_res.end = 0;
>>  	else
>>  		irq_res.flags = 0;
>>  
>>     
>
>   


--------------070500030100010105040908
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Ben Dooks wrote:
<blockquote cite="mid:20080811163648.GI26082@trinity.fluff.org"
 type="cite">
  <pre wrap="">
On Mon, Aug 11, 2008 at 07:19:13PM +0400, Anton Vorontsov wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">When no irq specified, pata_of_platform fills irq_res with -1,
which is wrong to do for two reasons:

1. By definition, 'no irq' should be IRQ 0, not some negative integer;
    </pre>
  </blockquote>
  <pre wrap=""><!---->
interesting, IRQ 0 is actually valid on some ARM systems.

  </pre>
</blockquote>
<br>
It is here too, but I believe most of the code uses a virtualized irq
number, so physical IRQ 0 would presumably get mapped to a non-zero
virtual one.<br>
<br>
<blockquote cite="mid:20080811163648.GI26082@trinity.fluff.org"
 type="cite">
  <pre wrap=""></pre>
  <blockquote type="cite">
    <pre wrap="">2. pata_platform checks for irq_res.start &gt; 0, but since irq_res.start
   is unsigned type, the check will be true for `-1'.

Reported-by: Steven A. Falco <a class="moz-txt-link-rfc2396E" href="mailto:sfalco@harris.com">&lt;sfalco@harris.com&gt;</a>
Signed-off-by: Anton Vorontsov <a class="moz-txt-link-rfc2396E" href="mailto:avorontsov@ru.mvista.com">&lt;avorontsov@ru.mvista.com&gt;</a>
---

On Mon, Aug 11, 2008 at 10:48:50AM -0400, Steven A. Falco wrote:
    </pre>
    <blockquote type="cite">
      <pre wrap="">I think there is a bug in the communications between pata_of_platform
and pata_platform.  I will refer to the master branch of the DENX git
tree, which is roughly v2.6.26.1 at this time.  I am using a Sequoia
board with a PPC440EPx.

In pata_of_platform, we have:

    ret = of_irq_to_resource(dn, 0, &amp;irq_res);
    if (ret == NO_IRQ)
        irq_res.start = irq_res.end = -1;

so if there is no interrupt defined, then start and end are -1. 
However, __pata_platform_probe has:

    if (irq_res &amp;&amp; irq_res-&gt;start &gt; 0) {
        irq = irq_res-&gt;start;
        irq_flags = irq_res-&gt;flags;
    }

You might think that the (irq_res-&gt;start &gt; 0) test will fail, as it
should in this no-irq case.  But, start is a u64, so the -1 actually
looks like a large positive number in the comparison.  So,
__pata_platform_probe attempts to use an interrupt when there isn't one.

I think the fix would be to change __pata_platform_probe to:

    if (irq_res &amp;&amp; irq_res-&gt;start != -1) {

but that might have other unintended consequences, so I'll defer to
whomever knows more about the intent of this code.
      </pre>
    </blockquote>
    <pre wrap="">Something like this patch should work. Thanks for noticing!

 drivers/ata/pata_of_platform.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/pata_of_platform.c b/drivers/ata/pata_of_platform.c
index 408da30..1f18ad9 100644
--- a/drivers/ata/pata_of_platform.c
+++ b/drivers/ata/pata_of_platform.c
@@ -52,7 +52,7 @@ static int __devinit pata_of_platform_probe(struct of_device *ofdev,
 
 	ret = of_irq_to_resource(dn, 0, &amp;irq_res);
 	if (ret == NO_IRQ)
-		irq_res.start = irq_res.end = -1;
+		irq_res.start = irq_res.end = 0;
 	else
 		irq_res.flags = 0;
 
    </pre>
  </blockquote>
  <pre wrap=""><!---->
  </pre>
</blockquote>
<br>
</body>
</html>

--------------070500030100010105040908--
