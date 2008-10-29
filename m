Return-Path: <jhsiao@amcc.com>
Received: from sdcmail02.amcc.com (sdcmail02.amcc.com [198.137.200.73])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "Messaging Gateway Appliance Demo Cert",
	Issuer "Messaging Gateway Appliance Demo Cert" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 423EEDDE01
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Oct 2008 13:17:13 +1100 (EST)
Subject: Re: [PATCH] AMCC Crypto4xx Device Driver v2]
From: James Hsiao <jhsiao@amcc.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20081028205132.255e674d@zod.rchland.ibm.com>
References: <1225237276.1850.13.camel@jhsiao-usb>
	<20081028205132.255e674d@zod.rchland.ibm.com>
Content-Type: text/plain
Date: Tue, 28 Oct 2008 19:18:20 -0700
Message-Id: <1225246700.1850.61.camel@jhsiao-usb>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: jhsiao@amcc.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Josh,

Yes, I did miss couple of Kim's comments.
Also, I did not include the message when I submit the V2 patch to Kim.
That patch have format problem so nobody except Kim recieved it.
 
Please see inline.

Thanks
James
On Tue, 2008-10-28 at 20:51 -0400, Josh Boyer wrote:
> On Tue, 28 Oct 2008 16:41:16 -0700
> James Hsiao <jhsiao@amcc.com> wrote:
> 
> > Hi Josh,
> > 
> > I am reposting this patch. Thanks Kim Phillips for pointing out format
> > of my patch. 
> > 
> > Again this patch was already reviewed by Kim Phillips on linux-crypyo.
> 
> Kim did a really good review and you only fixed a handful of easy
> things.
> 
> > Kim suggest us submit to linuxppc-dev for review.
> 
> Yeah, that's fine.  But generally you reply to all the
> questions/comments from the original review.  I see several unanswered
> comments that still apply to this version.  Things like:
> 
> - The device_type wasn't removed in the DTS change
Ok, I will remove it in V3 patch.

> - The question on ABLKCIPHER kconfig was ignored
Is ABLKCIPHER a sub set of BLKCIPHER? So, if BLKCIPHER is selected then
if ABLKCIPHER is present, it will use ABLKCIPHER otherwise using
BLKCIPHER algorithm? Correct?


> - Just returning -ENOMEM instead of using a goto for simple error cases
Yes, I miss that one.


> - Marking functions static
We have more than one file, that is why some of the function are not
static.

> - Global lsec_core variable which doesn't allow for more than one
> device
We only support single incidence of device.

> - Complete lack of locking code, how do you enforce mutually exclusive
> access to the device?

The crypto engine have couple bits 'command ready' and 'packet done',
which servers as semaphore here. So, software don't need extra locking.

> 
> I'll do a full review tomorrow because I see really odd things in here
> in addition to the above, but I'd like to know why those comments from
> Kim's review weren't answered.
> 
> josh
> 

 
