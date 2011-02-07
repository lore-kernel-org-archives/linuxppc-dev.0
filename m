Return-Path: <meador_inge@mentor.com>
Message-ID: <4D5033C9.8030407@mentor.com>
Date: Mon, 07 Feb 2011 12:02:49 -0600
From: Meador Inge <meador_inge@mentor.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v3 1/4] powerpc: Removing support for 'protected-sources'
References: <1296861941-3370-1-git-send-email-meador_inge@mentor.com>	
	<1296861941-3370-2-git-send-email-meador_inge@mentor.com>
	<1297035336.14982.14.camel@pasglop>
In-Reply-To: <1297035336.14982.14.camel@pasglop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Hollis Blanchard <hollis_blanchard@mentor.com>,
	devicetree-discuss@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/06/2011 05:35 PM, Benjamin Herrenschmidt wrote:
> On Fri, 2011-02-04 at 17:25 -0600, Meador Inge wrote:
>> In a recent thread [1,2,3] concerning device trees for AMP systems, the
>> question of whether we really need 'protected-sources' arose.  The general
>> consensus was that a new boolean property 'pic-no-reset' (described in more
>> detail in a following patch) could be expanded to cover the use cases that
>> 'protected-sources' was covering.
>>
>> One concern that was raised was for legacy systems which already use the
>> 'protected-sources' property [4].  For legacy use cases, 'protected-sources'
>> will be treated as an alias of 'pic-no-reset'.  The sources
>> encoded in the 'protected-sources' cells, however, will not be processed.  This
>> legacy check is added in a later patch in the series.
>
> I'm a bit annoyed here. Why do we need to do that ? Those Cell machines
> are going to be real bastards to find and test with, and I don't really
> see the point...

In my previous reply I said that "it is not so much as a need as it is a 
potential simplification."  After further reflection, I don't think that 
is completely true.  As we get into AMP systems with higher core counts, 
then implementing this functionality using the existing 
"protected-sources" implementation versus the new "pic-no-reset" work is 
going to be harder to maintain.

The reason being that *every* OS instance has to know about *every* 
other OSes interrupt sources, which is a little gross.  You can see this 
happening already in "arch/powerpc/boot/dts/p2020rdb_camp_core0.dts" and 
"arch/powerpc/boot/dts/p2020rdb_camp_core1.dts":

	// p2020rdb_camp_core0.dts
	mpic: pic@40000 {
	...
		// Sources used by the OS on core 1
		protected-sources = <
		42 76 77 78 79 /* serial1 , dma2 */
		29 30 34 26 /* enet0, pci1 */
		0xe0 0xe1 0xe2 0xe3 /* msi */
		0xe4 0xe5 0xe6 0xe7
		>;
	};

	// p2020rdb_camp_core1.dts
	mpic: pic@40000 {
	...
		// Sources used by the OS on core 0
		protected-sources = <
		17 18 43 42 59 47 /*ecm, mem, i2c, serial0, spi,gpio */
		16 20 21 22 23 28 	/* L2, dma1, USB */
		03 35 36 40 31 32 33 	/* mdio, enet1, enet2 */
		72 45 58 25 		/* sdhci, crypto , pci */
		>;
	};

It is going to be a real pain to keep all of the lists up to date. 
Especially considering we already have sufficient information in the 
device tree to do this work.  I do understand the concern of 
finding/testing the older systems.  However, is the testing of those 
systems enough to keep out the proposed change and potentially lower 
maintenance in the future?  Is the legacy system argument the only 
reason to keep this change out or are there other technical deficiencies?

Also, in the proposed MPIC modifications there is a check for protected 
sources (it is treated as an alias for "pic-no-reset"; see PATCH 3 in 
the set) that should provide functionality equivalent to what systems 
using "protected-sources" already have.  That check only looks for the 
presence of "protected-sources" and does not process the cells.  Another 
option would be to leave in the protected sources implementation (but 
undocumented in the binding) and have the full "pic-no-reset" behavior 
there as well (and documented in the binding).

If this has no chance of acceptance (?), then I will just re-submit the 
binding and implementation with "protected-sources" and the limited form 
of "pic-no-reset".

-- 
Meador Inge     | meador_inge AT mentor.com
Mentor Embedded | http://www.mentor.com/embedded-software
