Return-Path: <sam@ravnborg.org>
Received: from pqueueb.post.tele.dk (pqueueb.post.tele.dk [193.162.153.10])
	by ozlabs.org (Postfix) with ESMTP id 812ECB6F0E
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jul 2010 19:24:40 +1000 (EST)
Received: from pfepb.post.tele.dk (pfepb.post.tele.dk [195.41.46.236])
	by pqueueb.post.tele.dk (Postfix) with ESMTP id 93EEB814D
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jul 2010 10:54:25 +0200 (CEST)
Date: Tue, 13 Jul 2010 10:54:19 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: section .data..init_task
Message-ID: <20100713085419.GA5826@merkur.ravnborg.org>
References: <20100628005900.28d4a8e0@lappy.seanm.ca>
	<20100712203435.08a3e90f@lappy.seanm.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100712203435.08a3e90f@lappy.seanm.ca>
Cc: Denys Vlasenko <vda.linux@googlemail.com>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>, Tim Abbott <tabbott@ksplice.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 12, 2010 at 08:34:35PM -0400, Sean MacLennan wrote:
> On Mon, 28 Jun 2010 00:59:00 -0400
> Sean MacLennan <smaclennan@pikatech.com> wrote:
> 
> > Anybody else seeing these messages?
> > 
> > ppc_4xxFP-ld: .tmp_vmlinux1: section .data..init_task lma 0xc0374000
> > overlaps previous sections ppc_4xxFP-ld: .tmp_vmlinux2:
> > section .data..init_task lma 0xc03a2000 overlaps previous sections
> > ppc_4xxFP-ld: vmlinux: section .data..init_task lma 0xc03a2000
> > overlaps previous sections
> > 
> > Or does anybody know what they mean? They started showing up in
> > 2.6.35.
> > 
> > Very easy to reproduce, so don't hesitate to ask for more info.
> 
> I had a bit of time, so I tracked this down. This patch seems to be
> the culprit: http://lkml.org/lkml/2010/2/19/366
> 
> Specifically, this code:
> 
>  	/* The initial task and kernel stack */
> -	.data.init_task : AT(ADDR(.data.init_task) - LOAD_OFFSET) {
> -		INIT_TASK_DATA(THREAD_SIZE)
> -	}
> +	INIT_TASK_DATA_SECTION(THREAD_SIZE)
> 
> If I change it back to:
> 
> 	/* The initial task and kernel stack */
> 	.data..init_task : AT(ADDR(.data..init_task) - LOAD_OFFSET) {
> 		INIT_TASK_DATA(THREAD_SIZE)
> 	}
> 
> not only do the warnings go away, but the kernel now boots again!

It looks like a missing AT() in the output section.
The following patch should also fix it.

Please test and let us know.

Thanks,
	Sam


diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 48c5299..3c4bf03 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -435,7 +435,7 @@
  */
 #define INIT_TASK_DATA_SECTION(align)					\
 	. = ALIGN(align);						\
-	.data..init_task : {						\
+	.data..init_task : AT(ADDR(.data..init_task) - LOAD_OFFSET) {	\
 		INIT_TASK_DATA(align)					\
 	}
 
