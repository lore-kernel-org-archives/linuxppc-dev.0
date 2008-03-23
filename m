Return-Path: <schwab@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B5C83DDEED
	for <linuxppc-dev@ozlabs.org>; Sun, 23 Mar 2008 12:01:53 +1100 (EST)
From: Andreas Schwab <schwab@suse.de>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] windfarm: add PowerMac 12,1 support
References: <1201348525.6859.1.camel@thilivren>
	<1206214508.9540.89.camel@pmac.infradead.org>
	<1206223998.7197.13.camel@pasglop>
	<1206226966.9540.104.camel@pmac.infradead.org>
	<20080323102502.e0754062.sfr@canb.auug.org.au>
	<1206228673.9540.115.camel@pmac.infradead.org>
Date: Sun, 23 Mar 2008 02:01:46 +0100
In-Reply-To: <1206228673.9540.115.camel@pmac.infradead.org> (David Woodhouse's
	message of "Sat\, 22 Mar 2008 23\:31\:13 +0000")
Message-ID: <jefxui8d8l.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: =?iso-8859-1?Q?=C9tienne?= Bersac <bersace03@gmail.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Woodhouse <dwmw2@infradead.org> writes:

> -	all = all && pm121_register_control(ct, "optical-driver-fan", FAN_OD);
> -	all = all && pm121_register_control(ct, "hard-driver-fan", FAN_HD);
> -	all = all && pm121_register_control(ct, "cpu-driver-fan", FAN_CPU);
> -	all = all && pm121_register_control(ct, "cpufreq-clamp", CPUFREQ);
> +	all = pm121_register_control(ct, "optical-drive-fan", FAN_OD) && all;
> +	all = pm121_register_control(ct, "hard-drive-fan", FAN_HD) && all;
> +	all = pm121_register_control(ct, "cpu-fan", FAN_CPU) && all;
> +	all = pm121_register_control(ct, "cpufreq-clamp", CPUFREQ) && all;

You can also write all &= ... if pm121_register_control always return
0/1 (or make it 0/1 with !!).

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
