Return-Path: <mohan@in.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 62BAFB6F2B
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 11 Aug 2009 00:14:53 +1000 (EST)
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp08.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0E053DDD01
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Aug 2009 00:14:52 +1000 (EST)
Received: from d23relay02.au.ibm.com (d23relay02.au.ibm.com [202.81.31.244])
	by e23smtp08.au.ibm.com (8.14.3/8.13.1) with ESMTP id n7AEDUZM024272
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Aug 2009 00:13:30 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay02.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7AEEocs1229028
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Aug 2009 00:14:50 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7AEEnGN025344
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Aug 2009 00:14:50 +1000
Date: Mon, 10 Aug 2009 19:44:42 +0530
From: "M. Mohan Kumar" <mohan@in.ibm.com>
To: horms@verge.net.au, kexec@lists.infradead.org
Subject: [PATCH 2/2] Support R_PPC64_REL32 relocation type
Message-ID: <20090810141442.GE3110@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, nhorman@redhat.com, miltonm@bga.com
Reply-To: mohan@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[PATCH 2/2] Support R_PPC64_REL32 relocation type

gcc-4.4 compiler creates R_PPC64_REL32 relocation type in the ppc64
purgatory code. Add support to handle R_PPC64_REL32 relocation type.

Signed-off-by: M. Mohan Kumar <mohan@in.ibm.com>
---
 kexec/arch/ppc64/kexec-elf-rel-ppc64.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/kexec/arch/ppc64/kexec-elf-rel-ppc64.c b/kexec/arch/ppc64/kexec-elf-rel-ppc64.c
index 80543af..97aa34c 100644
--- a/kexec/arch/ppc64/kexec-elf-rel-ppc64.c
+++ b/kexec/arch/ppc64/kexec-elf-rel-ppc64.c
@@ -62,6 +62,10 @@ void machine_apply_elf_rel(struct mem_ehdr *ehdr, unsigned long r_type,
 		*(uint64_t *)location = value;
 		break;
 
+	case R_PPC64_REL32:
+		*(uint32_t *)location = value - (uint32_t)location;
+		break;
+
 	case R_PPC64_TOC:
 		*(uint64_t *)location = my_r2(ehdr);
 		break;
-- 
1.6.2.5
