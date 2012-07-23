Return-Path: <paulus@ozlabs.org>
Date: Mon, 23 Jul 2012 10:27:38 +1000
From: Paul Mackerras <paulus@samba.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH -V3 10/11] arch/powerpc: Use 32bit array for slb cache
Message-ID: <20120723002738.GK17790@bloggs.ozlabs.ibm.com>
References: <1341839621-28332-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1341839621-28332-11-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1341839621-28332-11-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 09, 2012 at 06:43:40PM +0530, Aneesh Kumar K.V wrote:
> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> 
> With larger vsid we need to track more bits of ESID in slb cache
> for slb invalidate.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Minor comment below, but apart from that...

Reviewed-by: Paul Mackerras <paulus@samba.org>

> -	sldi	r11,r3,1		/* r11 = offset * sizeof(u16) */
> -	rldicl	r10,r10,36,28		/* get low 16 bits of the ESID */
> -	add	r11,r11,r13		/* r11 = (u16 *)paca + offset */
> -	sth	r10,PACASLBCACHE(r11)	/* paca->slb_cache[offset] = esid */
> +	sldi	r11,r3,2		/* r11 = offset * sizeof(u32) */
> +	rldicl	r10,r10,36,28		/* get the 36 bits of the ESID */

You're correct that the rldicl instruction produces 36 bits of result,
and in fact it is equivalent to srdi r10,r10,28.  If you're changing
the line you might as well change the instruction to the simpler form
too.

Paul.
