Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 34BA2DDEE9
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Aug 2008 18:59:13 +1000 (EST)
In-Reply-To: <1218180939.24157.332.camel@pasglop>
References: <1218180939.24157.332.camel@pasglop>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <31233EB5-037E-4615-95C9-7C816E510752@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Strange tg3 regression with UMP fw. link reporting
Date: Fri, 8 Aug 2008 10:58:58 +0200
To: benh@kernel.crashing.org
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, Nathan Lynch <ntl@pobox.com>,
	mcarlson@broadcom.com, Michael Chan <mchan@broadcom.com>,
	netdev <netdev@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> I don't know yet for sure what happens, but a quick look at the commit
> seems to show that the driver synchronously spin-waits for up to 2.5ms

That's what the comment says, but the code says 2.5 _seconds_:

+       /* Wait for up to 2.5 milliseconds */
+       for (i = 0; i < 250000; i++) {
+               if (!(tr32(GRC_RX_CPU_EVENT) & GRC_RX_CPU_DRIVER_EVENT))
+                       break;
+               udelay(10);
+       }

(not that milliseconds wouldn't be bad already...)


Segher
