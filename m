Return-Path: <gkurz@linux.vnet.ibm.com>
Received: from e06smtp17.uk.ibm.com (e06smtp17.uk.ibm.com [195.75.94.113])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 81419140098
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Mar 2014 19:47:27 +1100 (EST)
Received: from /spool/local
 by e06smtp17.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gkurz@linux.vnet.ibm.com>;
 Mon, 31 Mar 2014 09:47:22 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id AE1261B0804B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Mar 2014 09:47:13 +0100 (BST)
Received: from d06av03.portsmouth.uk.ibm.com (d06av03.portsmouth.uk.ibm.com
 [9.149.37.213])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2V8l6Al721182
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Mar 2014 08:47:06 GMT
Received: from d06av03.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av03.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2V8lHD3027072
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Mar 2014 02:47:18 -0600
Date: Mon, 31 Mar 2014 10:47:16 +0200
From: Greg Kurz <gkurz@linux.vnet.ibm.com>
To: Stewart Smith <stewart@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/le: enable RTAS events support
Message-ID: <20140331104716.1385b516@bahia.local>
In-Reply-To: <87vbuv9vaz.fsf@river.i-did-not-set--mail-host-address--so-tickle-me>
References: <20140328073344.26823.32931.stgit@bahia.local>
 <87vbuv9vaz.fsf@river.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org, paulus@samba.org, anton@samba.org,
 nfont@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 31 Mar 2014 09:27:16 +1100
Stewart Smith <stewart@linux.vnet.ibm.com> wrote:
> Greg Kurz <gkurz@linux.vnet.ibm.com> writes:
> >  struct rtas_error_log {
> > +#ifdef __BIG_ENDIAN__
> > +	/* Byte 0 */
> >  	unsigned long version:8;		/* Architectural version */
> > +	/* Byte 1 */
> 
> I think it would be great if we got rid of the usage of bitfields. As
> soon as the mood of the compiler changes, this code is going to break.

True... even though I am not so sure the compiler is likely to break
things in this specific case where no bitfield crosses the byte boundary.
Anyway, Nathan has done some work in the direction you suggest.

Nathan,

Could you send your patch to the list ?

Thanks.

-- 
Gregory Kurz                                     kurzgreg@fr.ibm.com
                                                 gkurz@linux.vnet.ibm.com
Software Engineer @ IBM/Meiosys                  http://www.ibm.com
Tel +33 (0)562 165 496

"Anarchy is about taking complete responsibility for yourself."
        Alan Moore.
