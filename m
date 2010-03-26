Return-Path: <wmb@firmworks.com>
Received: from rs35.luxsci.com (rs35.luxsci.com [66.216.127.90])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 151E4B7CA6
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Mar 2010 05:48:23 +1100 (EST)
Message-ID: <4BAD017F.6090109@firmworks.com>
Date: Fri, 26 Mar 2010 08:48:31 -1000
From: Mitch Bradley <wmb@firmworks.com>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] powerpc/fsl: add device tree binding for QE firmware
References: <1269380552-10418-1-git-send-email-timur@freescale.com>
	<fa686aa41003241007mf6052d5s4643795f4a87cdcf@mail.gmail.com>
	<4BAA4C8A.70104@freescale.com>
	<65327.84.105.60.153.1269481760.squirrel@gate.crashing.org>
	<4BAB7E67.6040707@freescale.com> <4BAB816F.5060405@firmworks.com>
	<fa686aa41003250916t3d0839e5m42d7f7f6540e821a@mail.gmail.com>
	<4BAB9120.1060600@freescale.com>
	<fa686aa41003251826m16ea94dfy422fae14fec81204@mail.gmail.com>
	<4BACD011.5050609@freescale.com>
	<fa686aa41003261120o15fea3cev8ca625f389bc8664@mail.gmail.com>
	<4BACFF7B.3010002@freescale.com>
In-Reply-To: <4BACFF7B.3010002@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Scott Wood <scottwood@freescale.com>, devicetree-discuss@lists.ozlabs.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Timur Tabi wrote:
> Grant Likely wrote:
>   
>>> Without the compatible property, the only way I'd know that the child node contains a firmware is to look at the actual name of the child node, which (as Scott and I believe) is not better than a compatible property.
>>>       
>> If it is always a child of a qe node, then I've got no objections.
>>     
>
> I have no problem with putting the firmware node as a child of the QE node and skipping the phandle property, but only as long as there's only one QE node.  Would you agree that this is bad:
>
> qe1: qe@e0080000 {
>         compatible = "fsl,qe";
>         qefw: fsl,qe_firmware {
>                 compatible="fsl,qe-firmware";
>                 fsl,firmware = /bininc/("firmware-blob.bin");
>                 fsl,qe-firmware-eccr = <0x00000000 0x00001230>;
>         }
>         ...
> }
>
> qe2: qe@e0090000 {
>         compatible = "fsl,qe";
> 	fsl,firmware-phandle = <&qefw>;
>         ...
> }
>
>   

It not any worse than having the firmware blob anywhere else that is not 
hierarchically related.

If one insists on purity of hierarchy, one could introduce a node above 
qe1 and qe2 and put the firmware blob in that parent node.  That 
captures the assertion that the two qe devices are in fact identical so 
the same firmware is suitable for both.
