Return-Path: <ben.menchaca@gmail.com>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.30])
	by ozlabs.org (Postfix) with ESMTP id 67BA1DDF11
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Mar 2009 15:32:58 +1100 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so159787yxb.39
	for <linuxppc-dev@ozlabs.org>; Thu, 05 Mar 2009 20:32:56 -0800 (PST)
MIME-Version: 1.0
Date: Thu, 5 Mar 2009 22:32:56 -0600
Message-ID: <64ac01180903052032i75792fa6x864f91c511b3f228@mail.gmail.com>
Subject: 83xx: Marking or Allocating Pages as Cache-Inhibited
From: Ben Menchaca <ben.menchaca@gmail.com>
To: linuxppc-dev@ozlabs.org
Content-Type: multipart/alternative; boundary=00221532cba0652b5804646bc7cf
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--00221532cba0652b5804646bc7cf
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

I am working on a Freescale 8314e design, and the embedded device is
configured as a PCI-e endpoint running a 2.6.27-5 kernel.  For context, we
have written a kernel module which, among other things, uses the RDMA/WDMA
engine in the PCI-e IP block.  On the host side, these DMAs are coherent.
However, on the embedded side, things are quite a bit less rosy; we must
manually flush/invalidate cache lines for WDMA/RDMAs to occur successfully.
After speaking with (several) FAEs at Freescale, we believe there is a
configuration issue that is the cause, but we have yet to have anyone
successfully point to it.

Disabling the data cache altogether resolves the issue entirely, but of
course, also completely tanks performance.  As a temporary workaround, I
would like to simply mark the pages (obtained currently via
dma_alloc_coherent) involved as cache-inhibited.  I have attempted to do
this via some snippets remaining in fec.c (va_to_pte, uncache_pte to set
_PAGE_NO_CACHE, flush_tlb_page, then unmap_pte), but this is almost
certainly braindead; va_to_pte is not a part of the 83xx source, as far as I
can tell; 8xx only.

A quick pointer in the correct direction for marking pages as
cache-inhibited on a 2.6.27-5 kernel would be appreciated, or if my approach
to a workaround is flawed, a pointer to the correct way would be great.

Ben Menchaca

--00221532cba0652b5804646bc7cf
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I am working on a Freescale 8314e design, and the embedded device is config=
ured as a PCI-e
endpoint running a 2.6.27-5 kernel.=A0 For context, we have written a kerne=
l module
which, among other things, uses the
RDMA/WDMA engine in the PCI-e IP block.=A0 On the host side, these DMAs are=
 coherent.=A0 However, on the embedded side, things are quite a bit less ro=
sy; we
must manually flush/invalidate cache lines for WDMA/RDMAs to occur
successfully.=A0 After speaking with (several) FAEs at Freescale, we believ=
e there is a configuration issue that is the cause, but we have yet to have=
 anyone successfully point to it.=A0 <br>
<br>
Disabling the data cache altogether resolves the issue entirely, but of
course, also completely tanks performance.=A0 As a temporary workaround,
I would like to simply mark the pages (obtained currently via dma_alloc_coh=
erent) involved as cache-inhibited.=A0 I
have attempted to do this via some snippets remaining in fec.c
(va_to_pte, uncache_pte to set _PAGE_NO_CACHE, flush_tlb_page, then unmap_p=
te), but this is almost certainly braindead; va_to_pte is not a part of the=
 83xx source, as far as I can tell; 8xx only.<br><br>
A quick pointer in the correct direction for marking pages as cache-inhibit=
ed on a 2.6.27-5 kernel would be appreciated, or if my approach to a workar=
ound is flawed, a pointer to the correct way would be great.<br><br>Ben Men=
chaca<br>

--00221532cba0652b5804646bc7cf--
