Message-Id: <5.1.0.14.2.20030513232326.0350da78@mail.ebshome.net>
Date: Tue, 13 May 2003 23:41:22 -0700
To: Dan Malek <dan@embeddededge.com>
From: Eugene Surovegin <ebs@ebshome.net>
Subject: Re: set_rtc_time() cleanup / normalization
Cc: Matt Porter <mporter@kernel.crashing.org>,
	Wolfgang Denk <wd@denx.de>, Paul Mackerras <paulus@samba.org>,
	linuxppc-dev@lists.linuxppc.org
In-Reply-To: <3EC1DB1F.8000408@embeddededge.com>
References: <5.1.0.14.2.20030513171616.037f6800@mail.ebshome.net>
 <Your <5.1.0.14.2.20030513161846.03805338@mail.ebshome.net>
 <20030514000820.B3397C6092@atlas.denx.de>
 <5.1.0.14.2.20030513171616.037f6800@mail.ebshome.net>
 <5.1.0.14.2.20030513214040.02a6e6d0@mail.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 10:58 PM 5/13/2003, Dan Malek wrote:
>Eugene Surovegin wrote:
>
>>Why PPC arch should be different in this respect from other archs (like
>>i386, alpha, mips, mips64, sparc...)?
>
>PPC is different only that it follows the i386 model.  IIRC, the others
>have some selectable (or removed) feature for keeping the rtc updated.
>When you have an inflexible and essentially memory mapped device (like
>on i386) it makes sense to not have any options.  With embedded systems,
>you have a variety of options that don't always fit this model.

Exactly, I use this feature on our systems, somebody doesn't use it at all.

So far, the only *real* issue I've seen here is that some RTC drivers weren't
written correctly.

When I wrote RTC driver for out hw, simple grep through the code revealed
the fact, that ppc_md.set_rtc_time was called from interrupt context.
It's not a rocket science.

So all this surprise about kernel setting RTC is a little strange for me.
And yes, kernel *will* crash if you write a buggy driver.

I don't understand why instead of fixing those drivers we should remove
this feature altogether.

>>Frankly, I expect my tipb to behave exactly the same as my Intel box.
>
>Why would you want such a superior architecture like tipb to work
>so poorly? :-)

Well, I just use tipb as an example of box running PPC kernel which has the
same setup as my Intel box running the same kernel version.

>The tipb isn't the issue, but if you look carefully
>at all of these systems they all use user space programs to ensure
>the rtc and system date/time/timezone are set properly.
>
>>Maybe we should raise this issue on lkml?
>
>They won't care.  One, it's not x86, two, it's architecture specific.

Well, it's not entirely arch specific.
This behavior is *documented* (see hwclock(8) man pages for example).

Eugene.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
