Return-Path: <vbendeb@gmail.com>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.227])
	by ozlabs.org (Postfix) with ESMTP id 12F94DDFD2
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 20 Sep 2008 07:47:19 +1000 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so575501rvb.9
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 19 Sep 2008 14:47:18 -0700 (PDT)
Message-ID: <f608b67d0809191447q2bd5c05bof4610a3df17f8512@mail.gmail.com>
Date: Fri, 19 Sep 2008 14:47:18 -0700
From: vb <vb@vsbe.com>
Sender: vbendeb@gmail.com
To: linuxppc-embedded@ozlabs.org
Subject: Allocating uncached memory in 2.6.25(powerpc/440)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I wonder if anyone can help with some hints in this situation:

here is a code fragment to illustrate my question:

if ((ai = kmalloc(sizeof(alloc_info_t) + 4 * szw, GFP_ATOMIC |
GFP_DMA)) != NULL) {
        ai->src = FROM_KMALLOC;
printk("\n%s:%d %p\n", __FUNCTION__, __LINE__, ai);
 while(szw) {
