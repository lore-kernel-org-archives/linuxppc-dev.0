Return-Path: <paulus@ozlabs.org>
Date: Mon, 30 Jul 2012 10:58:03 +1000
From: Paul Mackerras <paulus@samba.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH -V4 11/12] arch/powerpc: properly offset the context bits
 for 1T segemnts
Message-ID: <20120730005803.GB21364@bloggs.ozlabs.ibm.com>
References: <1343221085-30661-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1343221085-30661-12-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1343221085-30661-12-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 25, 2012 at 06:28:04PM +0530, Aneesh Kumar K.V wrote:
> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> 
> We should do rldimi r10,r9,USER_ESID_BITS,0 only after populating
> r10 with ESID bits.

This needs a lot more explanation as to what the problem is that this
patch aims to fix.  Is it a problem today without your other patches,
or is it introduced by previous patches?

In any case I think there is an error in the patch, see below...

>  0:	/* user address: proto-VSID = context << 15 | ESID. First check
> @@ -155,13 +157,16 @@ END_MMU_FTR_SECTION_IFCLR(MMU_FTR_1T_SEGMENT)
>  	ld	r9,PACACONTEXTID(r13)
>  BEGIN_FTR_SECTION
>  	cmpldi	r10,0x1000
> +	bge	9f
>  END_MMU_FTR_SECTION_IFSET(MMU_FTR_1T_SEGMENT)
>  	rldimi	r10,r9,USER_ESID_BITS,0
> +	b	slb_finish_load
>  BEGIN_FTR_SECTION
> -	bge	slb_finish_load_1T
> +9:
> +	srdi	r10,r10,40-28		/* get 1T ESID */
> +	rldimi	r10,r9,USER_ESID_BITS,0

Shouldn't this one be USER_ESID_BITS_1T?  And in that case, since
USER_ESID_BITS == USER_ESID_BITS_1T + 12, I think the patch would
then introduce no change in behaviour (other than being slightly
slower than the current code).  Or am I missing something? -- in
that case we really need a longer and better explanation with the
patch.

Paul.
