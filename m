Return-Path: <tnt@246tNt.com>
Message-ID: <43E48722.8060103@246tNt.com>
Date: Sat, 04 Feb 2006 11:51:14 +0100
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: roman.kuzmenko@auriga.ru
Subject: Re: MPC5200, PCI, udelay(10)
References: <1137745904.4631.17.camel@trust.auriga.ru>
In-Reply-To: <1137745904.4631.17.camel@trust.auriga.ru>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linuxppc-embedded <Linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Roman Kuzmenko wrote:
> Hello.
> 
> Please, help me to investigate why the delays present in the
> "mpc5xxx_read_config_dword" and "mpc5xxx_write_config_dword" functions
> in the "arch/ppc/kernel/mpc52xx_pci.c" file.
> 
> I.e.
> ==========================
>   *(volatile u32 *)MPC5xxx_PCI_CAR = 0;
> 
>>udelay(10);
> 
>   return 0;
> ==========================
> 
> I was neither able to find any reference at the MPC5200 documentation
> supplied by FreeScale nor reproduce any error with these lines got
> removed.

I wasn't able to reproduce any problem either but people kept reporting
problems. But it seems that it's not a delay that's needed but a mb() to
ensure the write all _completly_ done before the next write. A
udelay(10) almost ensure that also but is a lot less elegant imho.


	Sylvain
