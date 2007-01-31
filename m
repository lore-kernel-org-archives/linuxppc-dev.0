Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound2-cpk-R.bigfish.com (outbound-cpk.frontbridge.com
	[207.46.163.16])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 6232EDDF5F
	for <linuxppc-dev@ozlabs.org>; Thu,  1 Feb 2007 03:35:01 +1100 (EST)
Message-ID: <45C0C530.4040407@am.sony.com>
Date: Wed, 31 Jan 2007 08:34:56 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [PATCH 2/10] ps3: AV Settings Driver Library
References: <Pine.LNX.4.62.0701301754050.29343@pademelon.sonytel.be>
	<Pine.LNX.4.62.0701301800020.29487@pademelon.sonytel.be>
In-Reply-To: <Pine.LNX.4.62.0701301800020.29487@pademelon.sonytel.be>
Content-Type: text/plain; charset=UTF-8
Cc: Paul Mackerras <paulus@samba.org>, James Simmons <jsimmons@infradead.org>,
	Linux Frame Buffer Device Development
	<linux-fbdev-devel@lists.sourceforge.net>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Geert Uytterhoeven wrote:
> Add the PS3 AV Settings Driver Library.
> 
> The AV Settings driver is used to control Audio and Video settings.
> It communicates with the policy manager through the virtual uart.
> 
...  
> +config PS3_PS3AV
> +	tristate "PS3 AV settings driver library"
> +	select PS3_VUART
> +	default y
> +	help
> +	  Include support for the PS3 Platform AV Settings driver library.

Sorry for not saying something before, but I really don't like calling this
a library.  It is modeled as a driver, shows up as a device/driver pair under
/sys/bus/ps3_vuart/, and services a vuart port device.  It should also be fixed
to work as a lodable module.  I think calling it a driver much better
communicates how it fits into the device model.

-Geoff
