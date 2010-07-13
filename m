Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id A5BCEB6F0C
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jul 2010 10:34:38 +1000 (EST)
Date: Mon, 12 Jul 2010 20:34:35 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: Denys Vlasenko <vda.linux@googlemail.com>, linuxppc-dev
	<linuxppc-dev@ozlabs.org>, Tim Abbott <tabbott@ksplice.com>, Sam Ravnborg
	<sam@ravnborg.org>
Subject: Re: section .data..init_task
Message-ID: <20100712203435.08a3e90f@lappy.seanm.ca>
In-Reply-To: <20100628005900.28d4a8e0@lappy.seanm.ca>
References: <20100628005900.28d4a8e0@lappy.seanm.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 28 Jun 2010 00:59:00 -0400
Sean MacLennan <smaclennan@pikatech.com> wrote:

> Anybody else seeing these messages?
> 
> ppc_4xxFP-ld: .tmp_vmlinux1: section .data..init_task lma 0xc0374000
> overlaps previous sections ppc_4xxFP-ld: .tmp_vmlinux2:
> section .data..init_task lma 0xc03a2000 overlaps previous sections
> ppc_4xxFP-ld: vmlinux: section .data..init_task lma 0xc03a2000
> overlaps previous sections
> 
> Or does anybody know what they mean? They started showing up in
> 2.6.35.
> 
> Very easy to reproduce, so don't hesitate to ask for more info.

I had a bit of time, so I tracked this down. This patch seems to be
the culprit: http://lkml.org/lkml/2010/2/19/366

Specifically, this code:

 	/* The initial task and kernel stack */
-	.data.init_task : AT(ADDR(.data.init_task) - LOAD_OFFSET) {
-		INIT_TASK_DATA(THREAD_SIZE)
-	}
+	INIT_TASK_DATA_SECTION(THREAD_SIZE)

If I change it back to:

	/* The initial task and kernel stack */
	.data..init_task : AT(ADDR(.data..init_task) - LOAD_OFFSET) {
		INIT_TASK_DATA(THREAD_SIZE)
	}

not only do the warnings go away, but the kernel now boots again!

Cheers,
   Sean
