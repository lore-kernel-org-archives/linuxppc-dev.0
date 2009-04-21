Return-Path: <randy.dunlap@oracle.com>
Message-ID: <49EE4341.50701@oracle.com>
Date: Tue, 21 Apr 2009 15:05:53 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [BUILD FAILURE 11/12] Next April 21 : PPC64 randconfig
	[drivers/usb/host/ohci-hcd.o]
References: <1240340081.9110.144.camel@subratamodak.linux.ibm.com>
	<200904211203.36969.david-b@pacbell.net>
	<5A202317-5104-4784-845B-B8C46E0A3C48@kernel.crashing.org>
In-Reply-To: <5A202317-5104-4784-845B-B8C46E0A3C48@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: sachinp <sachinp@linux.vnet.ibm.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>, linux-usb@vger.kernel.org,
	linux-kernel <linux-kernel@vger.kernel.org>,
	David Brownell <david-b@pacbell.net>,
	Linuxppc-dev <Linuxppc-dev@ozlabs.org>,
	linux-next <linux-next@vger.kernel.org>, subrata@linux.vnet.ibm.com,
	Alexander Beregalov <a.beregalov@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> 
> On Apr 21, 2009, at 2:03 PM, David Brownell wrote:
> 
>> On Tuesday 21 April 2009, Subrata Modak wrote:
>>> Observing this for the first time:
>>>
>>> CC      drivers/usb/host/ohci-hcd.o
>>> In file included from drivers/usb/host/ohci-hcd.c:1060:
>>> drivers/usb/host/ohci-ppc-of.c:242:2: error: #error "No endianess
>>
>> Hmm, scripts/get_maintainer.pl doesn't report
>> the PPC folk who maintain that file and its
>> kbuild infrastructure.
>>
>> Can we have some PPC folk look at (and fix) this?
> 
> The problem is in the drivers/usb/host/Kconfig:
> 
> config USB_OHCI_HCD_PPC_OF_BE
>         bool "Support big endian HC"
>         depends on USB_OHCI_HCD_PPC_OF
>         default y
>         select USB_OHCI_BIG_ENDIAN_DESC
>         select USB_OHCI_BIG_ENDIAN_MMIO
> 
> config USB_OHCI_HCD_PPC_OF_LE
>         bool "Support little endian HC"
>         depends on USB_OHCI_HCD_PPC_OF
>         default n
>         select USB_OHCI_LITTLE_ENDIAN
> 
> Since its feasible to say 'n' to both we get the compile error.  How do
> we enforce having at least one set?

Looks like using "choice" without "optional" would do it.
See Documentation/kbuild/kconfig-language.txt and various examples
in Kconfig* files.

-- 
~Randy
