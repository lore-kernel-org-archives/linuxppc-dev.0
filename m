Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id DCF77DE001
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Apr 2009 09:27:32 +1000 (EST)
Date: Tue, 7 Apr 2009 19:27:28 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: "linuxppc-dev" <linuxppc-dev@ozlabs.org>
Subject: Re: Hotplug on PPC4xx
Message-ID: <20090407192728.7218eea9@lappy.seanm.ca>
In-Reply-To: <20090406182023.0729073a@lappy.seanm.ca>
References: <20090406182023.0729073a@lappy.seanm.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 6 Apr 2009 18:20:23 -0400
"Sean MacLennan" <sean.maclennan@ottawa.kanatek.ca> wrote:

> I am trying to run the /sbin/hotplug from the kernel and it doesn't
> work. Has anybody got it running?

I looked into it some more. It turns out that the env pointers are
freed before they are copied.

In kobject_uevent_env() if I change the line that calls the helper from
UMH_NO_WAIT to UMH_WAIT_EXEC, then it works... but probably at a loss
of performance.

		retval = call_usermodehelper(argv[0], argv,
					     env->envp, UMH_WAIT_EXEC);

Any other ideas?

Cheers,
   Sean
