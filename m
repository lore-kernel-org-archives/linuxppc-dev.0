Return-Path: <khali@linux-fr.org>
Received: from mallaury.nerim.net (smtp-100-sunday.noc.nerim.net [62.4.17.100])
	by ozlabs.org (Postfix) with ESMTP id E281BDDEC6
	for <linuxppc-dev@ozlabs.org>; Sun, 17 Feb 2008 21:52:41 +1100 (EST)
Date: Sun, 17 Feb 2008 11:52:37 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: [PATCH 2/2] i2c-ibm_iic driver
Message-ID: <20080217115237.55d9f6d1@hyperion.delvare>
In-Reply-To: <47B74D76.1000708@pikatech.com>
References: <4784FED1.2040206@pikatech.com> <47A14E23.50807@pikatech.com>
	<20080214094516.1b958ae4@hyperion.delvare>
	<47B66260.8010902@pikatech.com>
	<20080216103123.50a0128b@hyperion.delvare>
	<47B74D76.1000708@pikatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: LinuxPPC-dev <linuxppc-dev@ozlabs.org>, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Sean,

On Sat, 16 Feb 2008 15:54:14 -0500, Sean MacLennan wrote:
> Jean Delvare wrote:
> > Hi Sean,
> >
> > On Fri, 15 Feb 2008 23:11:12 -0500, Sean MacLennan wrote:
> >   
> >> Here is the of platform patch. I removed the retries and removed the spaces used for spacing.
> >>
> >> Cheers,
> >>    Sean
> >>
> >> Signed-off-by: Sean MacLennan <smaclennan@pikatech.com>
> >>     
> >
> > First of all: please run scripts/checkpatch.pl on your patch and fix
> > the reported errors. It tells me:
> >   total: 10 errors, 5 warnings, 222 lines checked
> > which is definitely too much.
> >   
> Many of the errors/warnings are from the cut and paste of the original 
> code. I realize this doesn't justify my new code, but does beg the 
> question; should I also cleanup the original code? And how much? I am 
> tempted to cleanup all but the #ifdef CONFIG_IBM_OCP part.

Just take care of the code you are adding. The old code will go away
soon anyway as I understand it, so don't bother cleaning it up.

> 
> A few comments, everything else I agree with.
> 
> >> +		return -ENOMEM;
> >> +	}
> >> +
> >> +	/* This assumes we don't mix index and non-index entries. */
> >> +	indexp = of_get_property(np, "index", NULL);
> >> +	dev->idx = indexp ? *indexp : index++;
> >>     
> >
> > I don't like this static index thing much. Can't you just make the
> > "index" OF property mandatory? Mixing ways to number things can become
> > very confusing. In particular as you are using dev->idx later to call
> > i2c_add_numbered_adapter(), the caller is really supposed to know what
> > they are doing with the bus numbers.
> >   
> I also don't really like mixing the two methods, hence the comment. I 
> did this so existing dts files, which don't currently have an index, 
> would work as is. Maybe it would be better to add the index?
> 
> Without my patch, or one like it, you cannot currently use the IBM IIC 
> in the arch/powerpc branch, so maybe now *is* the time to enforce an index?
> 
> So if nobody responds with a good reason not to, I will change the code 
> to require the index to be set. Less testing for me ;)

Yes, I think this is the right time to enforce the index.

> >> +	adap->timeout = 1;
> >> +	adap->nr = dev->idx;
> >>     
> >
> > Looks to me like the block above has much in common with the original
> > probe function, maybe it would be worth sharing the code to make future
> > maintenance easier?
> >   
> It is my understanding the the arch/ppc branch is going away in the 
> middle of the year. So I kept the of platform code separate and clean 
> expecting the CONFIG_IBM_OCP block to be removed in the near future. So 
> future maintenance should not be an issue.

OK, fine with me then.

> > Note that I cannot test the code so I am relying on the linuxppc-dev
> > folks to test it
> I can test the of platform code and the common code. I am not setup to 
> test the OCP code, which is why I am loath to change it. I use the IBM 
> IIC for access to an  ad7414 thermal chip (currently not in the kernel, 
> I am working on that too) and for reading an eeprom.

Note that Frank Edelhaeuser has submitted a driver for this chip
recently:
http://lists.lm-sensors.org/pipermail/lm-sensors/2008-February/022478.html
I didn't have time to review this patch yet, maybe you will want to do
it yourself.

-- 
Jean Delvare
