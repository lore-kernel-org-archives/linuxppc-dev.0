Return-Path: <Hollis_Blanchard@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Re: [RFC] MPIC Bindings and Bindings for AMP Systems
Date: Tue, 4 Jan 2011 12:14:47 -0800
Message-ID: <DD7A9A95166BF4418C4C1EB2033B6EE2038FA8C5@na3-mail.mgc.mentorg.com>
In-Reply-To: <4D13C402.2090209@mentor.com>
References: <4D12F171.7010103@mentor.com>
	<20101223185623.GA20384@angua.secretlab.ca>
	<4D13C402.2090209@mentor.com>
From: "Blanchard, Hollis" <Hollis_Blanchard@mentor.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Cc: "Inge, Meador" <meador_inge@mentor.com>,
	devicetree-discuss@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/23/2010 01:49 PM, Meador Inge wrote:
>
> We can't just remove the IRQ of the _other_ OS from the 'interrupts'=20
> property in the message node because we need to know the IRQ in order=20
> to talk to the other OS.  So, we use protected sources to tell the OS=20
> that an IRQ is not available for its own use, while at the same time=20
> keeping=20
> complete information on all the IRQ mappings for the message =
registers.
There's a simpler and more fundamental problem: the Linux MPIC driver=20
initializes the "VECPRI" register for all interrupt sources (which is=20
how you associate a source with a vector). We need the Linux driver not=20
to do this.

(The "no-reset" property solves a related problem: it tells the driver=20
not to use the hardware's special "reset all registers" bit.)

Hollis Blanchard
Mentor Graphics, Embedded Systems Division
