Return-Path: <linuxppc-dev+bounces-16568-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 783F6E8B397
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Feb 2026 04:05:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f5Rb30JNjz2xm3;
	Wed, 04 Feb 2026 15:05:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=82.65.109.163
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770177919;
	cv=none; b=Jf084mkeBlVXjxrHCrCYCraVkfHFkGNuTIwFiFsgAXi2ktD8fKznydLRvBwZEG3r5n9qlNM4qOV6Y5GekBsSvrZcPdyRVqnBnh813mybMJ32ZuIQTDvpDuxUlJ3vouA4eopL4xnqIReBNkJ5KtDYWzGrOkK4Y04lbND+n2gJSj9qpNTIxgeWDaPL0iStPcxD2+dGW5IB8FRfZLVI4E8bj5YpG2/UhZc7wlphQs2Sy+LyWPSej2aeNa+FlKBAoxm8smu1MWjx/Ecy47kDZcnTK8oyPjhH3XOxZFdbqoFyG3gleASRJ2mX38w5aPvN0zd2W4vIa84W6/5ehT3MfSUi0g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770177919; c=relaxed/relaxed;
	bh=LVTVmWN86Ol60p1ryxDrGlsCkD0bNDXb4fJvzdMX16E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VjbKH9+VM4x81NaZgSUQutsXU2fkRNHzmE7lRTUGr/n0FQqIeXi8StRnsTxc69H0Am6lEzrGvCyc18dczTaihjpBbr35BbySwGtpmfvpfoYqa0/6Fp4fxWAoGl0LiLeXvpVMbUArCI90ATYHi24xupEfV0PpVEUjRtoqfIwI6VekW69mhYB4qFzGSbfVMcdYJtRcC35zE4FDbuk0fLh8J3wTrIFJUUjyjOkQxTRNEmyT0Cna2hDuruE5sZ3OxME4hjMdZ0OlBlG7hCdPseSp42Ch8i5SAhtKh8mI7GVpeCh9LgI3GTvfR1Irl32gaYGLRFqQWgDDs1VCEIELNBHz3w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr; spf=pass (client-ip=82.65.109.163; helo=luna.linkmauve.fr; envelope-from=linkmauve@linkmauve.fr; receiver=lists.ozlabs.org) smtp.mailfrom=linkmauve.fr
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linkmauve.fr (client-ip=82.65.109.163; helo=luna.linkmauve.fr; envelope-from=linkmauve@linkmauve.fr; receiver=lists.ozlabs.org)
Received: from luna.linkmauve.fr (luna.linkmauve.fr [82.65.109.163])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f5Rb22bfsz3bf4
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Feb 2026 15:05:18 +1100 (AEDT)
Received: by luna.linkmauve.fr (Postfix, from userid 1000)
	id 10FA7F43B49; Wed, 04 Feb 2026 05:05:08 +0100 (CET)
From: Link Mauve <linkmauve@linkmauve.fr>
To: rust-for-linux@vger.kernel.org
Cc: Link Mauve <linkmauve@linkmauve.fr>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Srinivas Kandagatla <srini@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Eric Biggers <ebiggers@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lyude Paul <lyude@redhat.com>,
	Asahi Lina <lina+kernel@asahilina.net>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Tamir Duberstein <tamird@kernel.org>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	officialTechflashYT@gmail.com,
	Ash Logan <ash@heyquark.com>,
	Roberto Van Eeden <rw-r-r-0644@protonmail.com>,
	=?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: [PATCH v2 1/4] rust: io: Add big-endian read and write functions
Date: Wed,  4 Feb 2026 05:04:58 +0100
Message-ID: <20260204040505.8447-2-linkmauve@linkmauve.fr>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204040505.8447-1-linkmauve@linkmauve.fr>
References: <20260204040505.8447-1-linkmauve@linkmauve.fr>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Another option would be to call u32::swap_bytes() on the data being
read/written, but these helpers make the Rust code as ergonomic as the C
code.

Signed-off-by: Link Mauve <linkmauve@linkmauve.fr>
---
 rust/helpers/io.c | 34 ++++++++++++++++++++++++++++++++++
 rust/kernel/io.rs | 18 ++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/rust/helpers/io.c b/rust/helpers/io.c
index c475913c69e6..514ad0377327 100644
--- a/rust/helpers/io.c
+++ b/rust/helpers/io.c
@@ -40,6 +40,23 @@ u64 rust_helper_readq(const void __iomem *addr)
 }
 #endif
 
+u16 rust_helper_ioread16be(const void __iomem *addr)
+{
+	return ioread16be(addr);
+}
+
+u32 rust_helper_ioread32be(const void __iomem *addr)
+{
+	return ioread32be(addr);
+}
+
+#ifdef CONFIG_64BIT
+u64 rust_helper_ioread64be(const void __iomem *addr)
+{
+	return ioread64be(addr);
+}
+#endif
+
 void rust_helper_writeb(u8 value, void __iomem *addr)
 {
 	writeb(value, addr);
@@ -62,6 +79,23 @@ void rust_helper_writeq(u64 value, void __iomem *addr)
 }
 #endif
 
+void rust_helper_iowrite16be(u16 value, void __iomem *addr)
+{
+	iowrite16be(value, addr);
+}
+
+void rust_helper_iowrite32be(u32 value, void __iomem *addr)
+{
+	iowrite32be(value, addr);
+}
+
+#ifdef CONFIG_64BIT
+void rust_helper_iowrite64be(u64 value, void __iomem *addr)
+{
+	iowrite64be(value, addr);
+}
+#endif
+
 u8 rust_helper_readb_relaxed(const void __iomem *addr)
 {
 	return readb_relaxed(addr);
diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index 98e8b84e68d1..e6912e7ff036 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -256,6 +256,15 @@ fn io_addr_assert<U>(&self, offset: usize) -> usize {
         readq -> u64
     );
 
+    define_read!(read16be, try_read16be, ioread16be -> u16);
+    define_read!(read32be, try_read32be, ioread32be -> u32);
+    define_read!(
+        #[cfg(CONFIG_64BIT)]
+        read64be,
+        try_read64be,
+        ioread64be -> u64
+    );
+
     define_read!(read8_relaxed, try_read8_relaxed, readb_relaxed -> u8);
     define_read!(read16_relaxed, try_read16_relaxed, readw_relaxed -> u16);
     define_read!(read32_relaxed, try_read32_relaxed, readl_relaxed -> u32);
@@ -276,6 +285,15 @@ fn io_addr_assert<U>(&self, offset: usize) -> usize {
         writeq <- u64
     );
 
+    define_write!(write16be, try_write16be, iowrite16be <- u16);
+    define_write!(write32be, try_write32be, iowrite32be <- u32);
+    define_write!(
+        #[cfg(CONFIG_64BIT)]
+        write64be,
+        try_write64be,
+        iowrite64be <- u64
+    );
+
     define_write!(write8_relaxed, try_write8_relaxed, writeb_relaxed <- u8);
     define_write!(write16_relaxed, try_write16_relaxed, writew_relaxed <- u16);
     define_write!(write32_relaxed, try_write32_relaxed, writel_relaxed <- u32);
-- 
2.52.0


