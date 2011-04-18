Return-Path: <galak@kernel.crashing.org>
Subject: Re: [PATCH 12/15] powerpc/book3e: Use way 3 for linear mapping bolted
	entry
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <bbe411555c95e56ba427ebf638d5333b1870af77.1302856271.git.michael@ellerman.id.au>
Date: Mon, 18 Apr 2011 07:43:56 -0500
Message-Id: <FE1E8891-E134-4559-9F26-BAFC36B258AC@kernel.crashing.org>
References: <d284a5076d7760656470a5fd16d98ec6501a9bf3.1302856271.git.michael@ellerman.id.au>
	<bbe411555c95e56ba427ebf638d5333b1870af77.1302856271.git.michael@ellerman.id.au>
To: Michael Ellerman <michael@ozlabs.org>
Cc: Jimi Xenidis <jimix@watson.ibm.com>, linuxppc-dev@ozlabs.org,
	David Gibson <david@gibson.dropbear.id.au>, imunsie@au.ibm.com,
	jack@codezen.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Apr 15, 2011, at 3:32 AM, Michael Ellerman wrote:

> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>=20
> An erratum on A2 can lead to the bolted entry we insert for the linear
> mapping being evicted, to avoid that write the bolted entry to way 3.
>=20
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
> ---
> arch/powerpc/kernel/exceptions-64e.S |    5 +++--
> 1 files changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/powerpc/kernel/exceptions-64e.S =
b/arch/powerpc/kernel/exceptions-64e.S
> index 5c43063..e6c0926 100644
> --- a/arch/powerpc/kernel/exceptions-64e.S
> +++ b/arch/powerpc/kernel/exceptions-64e.S
> @@ -864,8 +864,9 @@ have_hes:
> 	 * that will have to be made dependent on whether we are running =
under
> 	 * a hypervisor I suppose.
> 	 */
> -	ori	r3,r3,MAS0_HES | MAS0_WQ_ALLWAYS
> -	mtspr	SPRN_MAS0,r3
> +	ori	r11,r3,MAS0_WQ_ALLWAYS
> +	oris	r11,r11,MAS0_ESEL(3)@h /* Use way 3: workaround A2 =
erratum 376 */
> +	mtspr	SPRN_MAS0,r11
> 	lis	r3,(MAS1_VALID | MAS1_IPROT)@h
> 	ori	r3,r3,BOOK3E_PAGESZ_1GB << MAS1_TSIZE_SHIFT
> 	mtspr	SPRN_MAS1,r3

Seems like this should have a MMU Feature bit or something for A2.

- k=
