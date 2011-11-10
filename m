Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 8A4C61007F4
 for <linuxppc-dev@ozlabs.org>; Fri, 11 Nov 2011 05:46:32 +1100 (EST)
Subject: Re: [RFC][PATCH 08/30] powerpc/85xx: Rework P1020 SoC device tree
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20111110180542.GA12203@schlenkerla.am.freescale.net>
Date: Thu, 10 Nov 2011 12:46:27 -0600
Message-Id: <5561C3BD-B4E5-4D82-84C4-B8715191DDE3@kernel.crashing.org>
References: <1320941653-29797-1-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-2-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-3-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-4-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-5-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-6-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-7-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-8-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-9-git-send-email-galak@kernel.crashing.org>
 <20111110180542.GA12203@schlenkerla.am.freescale.net>
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Nov 10, 2011, at 12:05 PM, Scott Wood wrote:

> On Thu, Nov 10, 2011 at 10:13:51AM -0600, Kumar Gala wrote:
>> Split the P1020 SoC device tree into what we can include as a =
'prefix'
>> to the board device tree and what needs to be included as a =
'postfix'.
>>=20
>> This allows use more re-use and less duplication between various =
board
>> device tree configurations (32-bit address map vs 36-bit address =
map).
>=20
> Could you elaborate on the issues that require this pre/post approach?

We utilize two 'features' of dtc to accomplish things.  One is includes =
the other is 'merging of labeled nodes'.

We can using merging to allow the board to specify the "reg" & "ranges" =
values of a SoC node that might vary between physical address maps =
(32-bit vs 36-bit as example).

dtc is able to 'merge' multiple labeled nodes as well.  So we use that =
to handle board specific values for something like localbus if we want =
to support both a 32-bit and 36-bit address map.

> What does the SoC part need to specify that has to override or go =
within
> something the board specifies?

Not sure I follow the question.

- k=
