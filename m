Return-Path: <wmb@firmworks.com>
Received: from rs35.luxsci.com (rs35.luxsci.com [66.216.127.90])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 76ED1B7CA6
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Mar 2010 05:58:33 +1100 (EST)
Message-ID: <4BAD03E2.9020207@firmworks.com>
Date: Fri, 26 Mar 2010 08:58:42 -1000
From: Mitch Bradley <wmb@firmworks.com>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] powerpc/fsl: add device tree binding for QE firmware
References: <1269380552-10418-1-git-send-email-timur@freescale.com>
	<65327.84.105.60.153.1269481760.squirrel@gate.crashing.org>
	<4BAB7E67.6040707@freescale.com> <4BAB816F.5060405@firmworks.com>
	<fa686aa41003250916t3d0839e5m42d7f7f6540e821a@mail.gmail.com>
	<4BAB9120.1060600@freescale.com>
	<fa686aa41003251826m16ea94dfy422fae14fec81204@mail.gmail.com>
	<4BACD011.5050609@freescale.com>
	<fa686aa41003261120o15fea3cev8ca625f389bc8664@mail.gmail.com>
	<4BACFF7B.3010002@freescale.com>
	<fa686aa41003261144i61429f23x1217a528fcfb3e66@mail.gmail.com>
	<4BAD018B.6010309@freescale.com>
In-Reply-To: <4BAD018B.6010309@freescale.com>
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
>   
>> Nah.  That looks totally fine.  Not having the firmware under a qe
>> node would look bad to me.
>>     
>
> You don't think it weird to have one QE node reference data from another QE node, or that the DTS implies that the firmware belongs to one QE more than it belongs to the other?
>   

It is certainly not symmetric.

Putting the firmware blob somewhere completely unrelated to either node 
maintains the symmetry between the two qe nodes, but only weakly 
captures the relationship between the firmware blob and the qe nodes.  
It is then necessary to invoke a strong naming convention for the 
firmware blob, because you don't have the hierarchy to do the name space 
disambiguation for you.

As I see it, the three possibilities, and their disadvantages, are:

a) Firmware blob in some random place - requires strong naming of either 
firmware blob property or node containing it.

b) Firmware blob within first qe node - asymmetric.

c) Firmware blob in new parent of both qe nodes - requires introduction 
of otherwise-unneeded hierarchy level.
