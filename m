Return-Path: <jonsmirl@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.178])
	by ozlabs.org (Postfix) with ESMTP id 60AFDDE01A
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 14 Dec 2007 13:28:29 +1100 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so1491418wag.13
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 13 Dec 2007 18:28:28 -0800 (PST)
Message-ID: <9e4733910712131828v532e6aaep316c72e14d92c921@mail.gmail.com>
Date: Thu, 13 Dec 2007 21:28:28 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Bruce_Leonard@selinc.com" <Bruce_Leonard@selinc.com>
Subject: Re: How is a device tree used to specifiy flash?
In-Reply-To: <OFE841AC61.3D44C925-ON882573B0.007FA29F-882573B0.0080F67D@selinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <OFE841AC61.3D44C925-ON882573B0.007FA29F-882573B0.0080F67D@selinc.com>
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

To get this working on the mpc5200 I had to add the localbus node
above the flash.

	lpb@ff000000 {
		compatible = "fsl,lpb";
		ranges = <0 ff000000 01000000>;
		
		flash@00000000 {
			compatible = "cfi-flash";
			reg = <00000000 01000000>;
			bank-width = <2>;
			#size-cells = <1>;
			#address-cells = <1>;
			partition@0 {
				label = "ubootl";
				reg = <00000000 00040000>;
			};
			partition@40000 {
				label = "kernel";
				reg = <00040000 001c0000>;
			};
			partition@200000 {
				label = "jffs2";
				reg = <00200000 00D00000>;
			};
			partition@f00000 {
				label = "uboot";
				reg = <00f00000 00040000>;
			};
			partition@f40000 {
				label = "oftree";
				reg = <00f40000 00040000>;
			};
			partition@f80000 {
				label = "space";
				reg = <00f80000 00080000>;
			};
		};
	};


-- 
Jon Smirl
jonsmirl@gmail.com
