Return-Path: <B07421@freescale.com>
Message-ID: <4E6FA1E2.2060706@freescale.com>
Date: Tue, 13 Sep 2011 13:33:06 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Tabi Timur-B04825 <B04825@freescale.com>
Subject: Re: [PATCH] powerpc/fsl_msi: Handle msi-available-ranges better
References: <20110117202528.GB561@udp111988uds.am.freescale.net>
	<CAOZdJXVm1YL-T8i26O0BiB-uTkXUDnYQdacU8k52aG-K0pZ1Lg@mail.gmail.com>
In-Reply-To: <CAOZdJXVm1YL-T8i26O0BiB-uTkXUDnYQdacU8k52aG-K0pZ1Lg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Wood Scott-B07421 <B07421@freescale.com>,
	"devicetree-discuss@lists.ozlabs.org"
	<devicetree-discuss@lists.ozlabs.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/07/2011 11:20 AM, Tabi Timur-B04825 wrote:
> The problem is that both offset and irq_index are being incremented in
> the loop, and cascade_data->index is set to the sum of the two.
> 
> Perhaps you meant this:
> 
> 		err = fsl_msi_setup_hwirq(msi, dev, offset, j);

That's not right either, it would retrieve the wrong IRQ from the
interrupts property if you have holes -- try with something like
{ 0 64, 128, 64 }.  The desired behavior there is:

  offset = 0 irq_index = 0
  offset = 1 irq_index = 1
  offset = 4 irq_index = 2
  offset = 5 irq_index = 3

I think the right code (untested) might be:

	err = fsl_msi_setup_hwirq(msi, dev, offset + j, irq_index);

and

	cascade_data->index = offset;

-Scott
