Return-Path: <jonsmirl@gmail.com>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.234])
	by ozlabs.org (Postfix) with ESMTP id 9A379DDEE2
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jun 2008 14:08:51 +1000 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so2771766rvb.9
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jun 2008 21:08:50 -0700 (PDT)
Message-ID: <9e4733910806102108t53ed0b21ya4785502c9e93f88@mail.gmail.com>
Date: Wed, 11 Jun 2008 00:08:50 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: Comments on device tree for pcm030
In-Reply-To: <fa686aa40806100626t14ee44fnc1108426b73fc7fd@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910806081208r1a8d0987j6eab0d73bc446640@mail.gmail.com>
	<9e4733910806091430j56aeb06bpa090b0c8242e2041@mail.gmail.com>
	<200806101020.38788.jbe@pengutronix.de>
	<200806101105.15080.jbe@pengutronix.de>
	<fa686aa40806100626t14ee44fnc1108426b73fc7fd@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 6/10/08, Grant Likely <grant.likely@secretlab.ca> wrote:
> On Tue, Jun 10, 2008 at 3:05 AM, Juergen Beisert <jbe@pengutronix.de> wrote:
>  > Maybe everything in this small piece of my dts is wrong. But I don't know how
>  > the correct way is. All I want is to define a 32MiB flash at the end if the
>  > address space of my MPC5200B based system.

I adjusted my previous DTS for the current dtc compiler. This boots on
my pcm030.

If the uboot image for the pcm030 had a redboot compatible partition
table we wouldn't need to specify them in the device tree.

	lpb@ff000000 {
		compatible = "fsl,lpb";
		#address-cells = <2>;
		#size-cells = <1>;
		ranges = <0 0 0xff000000 0x01000000>;
		
		flash@0 {
			compatible = "cfi-flash";
			reg = <0 0 0x01000000>;
			bank-width = <2>;
			device-width = <2>;
			#size-cells = <1>;
			#address-cells = <1>;
			partition@0 {
				label = "ubootl";
				reg = <0x00000000 0x00040000>;
			};
			partition@40000 {
				label = "kernel";
				reg = <0x00040000 0x001c0000>;
			};
			partition@200000 {
				label = "jffs2";
				reg = <0x00200000 0x00D00000>;
			};
			partition@f00000 {
				label = "uboot";
				reg = <0x00f00000 0x00040000>;
			};
			partition@f40000 {
				label = "oftree";
				reg = <0x00f40000 0x00040000>;
			};
			partition@f80000 {
				label = "space";
				reg = <0x00f80000 0x00080000>;
			};
		};
	};
	
ff000000.flash: Found 1 x16 devices at 0x0 in 16-bit bank
 Intel/Sharp Extended Query Table at 0x0031
Using buffer write method
cfi_cmdset_0001: Erase suspend on write enabled
Searching for RedBoot partition table in ff000000.flash at offset 0xfe0000
No RedBoot partition table detected in ff000000.flash
Creating 6 MTD partitions on "ff000000.flash":
0x00000000-0x00040000 : "ubootl"
0x00040000-0x00200000 : "kernel"
0x00200000-0x00f00000 : "jffs2"
0x00f00000-0x00f40000 : "uboot"
0x00f40000-0x00f80000 : "oftree"
0x00f80000-0x01000000 : "space"


-- 
Jon Smirl
jonsmirl@gmail.com
