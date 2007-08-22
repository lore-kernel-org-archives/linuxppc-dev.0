Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18123.37125.712301.914626@cargo.ozlabs.ibm.com>
Date: Wed, 22 Aug 2007 11:27:33 +1000
From: Paul Mackerras <paulus@samba.org>
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] powerpc: Fix race in the pasemi timebase calibration
In-Reply-To: <20070821220631.GA4304@lixom.net>
References: <20070821220631.GA4304@lixom.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olof Johansson writes:

> Make sure the new timebase value is available by the time take_timebase
> completes. Otherwise take_timebase might race with give_timebase,
> causing severe badness when the value later is modified (think looong
> hang trying to catch up with a very large number of lost ticks).

OK.

> @@ -61,6 +62,7 @@ static void __devinit pas_give_timebase(
>  	mtspr(SPRN_TBCTL, TBCTL_UPDATE_LOWER | (tb & 0xffffffff));
>  	mtspr(SPRN_TBCTL, TBCTL_UPDATE_UPPER | (tb >> 32));
>  	mtspr(SPRN_TBCTL, TBCTL_RESTART);
> +	timebase_avail = 1;

No memory barrier before setting timebase_avail?  Shouldn't there be
one?

Actually I don't understand that code at all.  Your give_timebase
seems to freeze the timebase, read it, set it to the same value and
restart, all without synchronizing with the other cpu, and your
take_timebase does nothing except print the timebase.  How does that
work?

Regards,
Paul.
