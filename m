Return-Path: <glikely@secretlab.ca>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.30])
	by ozlabs.org (Postfix) with ESMTP id C6051DDE1D
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Dec 2008 18:15:29 +1100 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so455937yxg.39
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Dec 2008 23:15:27 -0800 (PST)
Message-ID: <fa686aa40812192315l5bf965c6i7fb0cfb1683971cc@mail.gmail.com>
Date: Sat, 20 Dec 2008 00:15:27 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
To: "Matt Sealey" <matt@genesi-usa.com>, "Olaf Hering" <olaf@aepfle.de>
Subject: Re: [PATCH]: [MPC5200] Add ATA DMA support
In-Reply-To: <b5e2fc790811250719h21b2b0e5uc0a249a73458148f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <633A55242A59C7488FAAF5A6850929984B814A@SRVEXC01.sts.saurer.vpn>
	<b5e2fc790811250719h21b2b0e5uc0a249a73458148f@mail.gmail.com>
Cc: "Lehmann, Hans \(Ritter Elektronik\)" <hans.lehmann@ritter-elektronik.de>,
	Tim Yamin <plasm@roo.me.uk>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Nov 25, 2008 at 8:19 AM, Matt Sealey <matt@genesi-usa.com> wrote:
>
>
> On Tue, Nov 25, 2008 at 8:45 AM, Lehmann, Hans (Ritter Elektronik)
> <hans.lehmann@ritter-elektronik.de> wrote:
>>
>> Tim, Grant,
>>
>> just an info.
>>
>> Very often the Bestcomm-FEC crashed without any error logs if I initiate a
>> transaction over FEC and save the file to disk (I rememeber I have read
>> something like that). A restart of FEC don't work.
>> But no I figured out, if I connect to the other ethernet port of our board
>> (natsemi) the FEC will awake to life again, if I initiate a new transaction
>> over natsemi. This seems a little oddly to me.
>
> Hi guys,
>
> We tried to get the SUSE guys to push the patch into openSUSE 11.1 release
> and the tests came back negative here too with regards to FEC support; for
> some odd reason, it does this;
>
> https://bugzilla.novell.com/show_bug.cgi?id=445856#c10
>
> There is some weird interaction here, but I can't imagine what it might be.
> Tim, did you ever see any ethernet problems like this?

It looks like something getting messed up during allocation of buffers
and not DMA operation related at all.  I don't see the problem here...

Digging deeper I think the problem is due to this:

>   ------- Comment #6 From Olaf Hering 2008-11-18 01:32:52 MST  -------
>
> Also, the patches do not seem to apply and compile with our kernel-source.
> bcom_task->bd changed to void*, this breaks sound/ppc/mpc52xx_ac97.c. It looks
> like an unneeded cosmetic change.
> The Kconfig changes are appearently also not required for an existing .config.
>
> I removed the bcom_task->bd  change.

The patch does depend on bcom_task->bd being (void *).  Without it the
calculation of BD offsets is entirely wrong in bcom_get_bd().

That being said, the next version of the patch will leave the pointer
as (bcom_bd *) and handle the offset calculation in a different way.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
