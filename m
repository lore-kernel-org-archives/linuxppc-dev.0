Return-Path: <vitb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 23DB2DDE1F
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 31 Dec 2007 19:14:52 +1100 (EST)
Date: Mon, 31 Dec 2007 11:14:43 +0300
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: rmcguire@videopresence.com
Subject: Re: 83xx, ELDK 2.6.23, IP-Config: No network devices
Message-ID: <20071231111443.4c6d8691@kernel.crashing.org>
In-Reply-To: <000001c84b47$50b0e2b0$6405a8c0@absolut>
References: <mailman.1.1198890002.24584.linuxppc-embedded@ozlabs.org>
	<000001c84b47$50b0e2b0$6405a8c0@absolut>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Sun, 30 Dec 2007 16:51:44 -0800
Russell McGuire wrote:

> 1) Is there some basic kernel feature I am missing? I have enabled
> the GIGE UEC GETH driver in the kernel.  Perhaps a PHY LIB? Isn't
> generic MII supported by default?
> 
yes you will need phylib

> 2) Is there something in the startup board files, that I need to add
> to register my PHY like an of_put_node()? Again I have pretty much
> copied the MPC8360E MDS board and it is starting, and defining the
> par_io port already, except that my PHY ID <on the iC2 bus, is using
> dev ID 0x01>. However, I don't see the probe function being called,
> so I don't think this is a concern yet.
I think you will need to write a driver for your specific PHY access to get it covered by phy abstraction layer.
Generic mii thing is useful when it has access to phy regs somehow (live examples are some BCM phys that do not have specs
available but the thing works using generic mii and standard phy regs).

-- 
Sincerely, Vitaly
