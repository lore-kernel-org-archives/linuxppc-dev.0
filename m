Return-Path: <mditto@consentry.com>
Received: from tidalnetworks.net (mail.consentry.com [75.35.230.10])
	by ozlabs.org (Postfix) with ESMTP id AA833DDF77
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Jan 2009 12:28:29 +1100 (EST)
Message-ID: <49810367.5000904@consentry.com>
Date: Wed, 28 Jan 2009 17:16:23 -0800
From: Mike Ditto <mditto@consentry.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org, daniel.ng1234@gmail.com
Subject: Re: How to bring up fs_enet on 2.6.27?
References: <mailman.5.1233190802.9523.linuxppc-dev@ozlabs.org>
In-Reply-To: <mailman.5.1233190802.9523.linuxppc-dev@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Daniel Ng <daniel.ng1234@gmail.com> wrote:
> Should the device just be available as 'eth2', so that I can do
> 'ifconfig eth2 192.168.1.33'?

It will be eth0 if you have no other network devices.

>         // FCC2-
>         reg = <0x11320 0x20 0x8500 0x100 0x113b0 0x1>;
>         fsl,cpm-command = <0x12000300>;

That's not the right fsl,cpm-command for FCC2.  You want 0x16200300.

Also, for my similar board, I had to add (for immap at F0000000):
	virtual-reg = <0xF0011320
		       0xF0008500
		       0xF00113B0>;

But I can't explain why the driver isn't attaching for you.  Did you
try it built-in instead of as a module?

					-=] Mike [=-
