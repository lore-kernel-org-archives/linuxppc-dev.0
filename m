Return-Path: <torvalds@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4A44BB7CE7
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 23 Mar 2010 05:12:40 +1100 (EST)
Date: Mon, 22 Mar 2010 11:07:14 -0700 (PDT)
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: ppc64 sys_ipc breakage in 2.6.34-rc2
In-Reply-To: <m2ocigkzij.fsf@igel.home>
Message-ID: <alpine.LFD.2.00.1003221102050.18017@i5.linux-foundation.org>
References: <20100322064759.GE24064@kryten> <m2ocigkzij.fsf@igel.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-7
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Christoph Hellwig <hch@lst.de>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Hirokazu Takata <takata@linux-m32r.org>, James Morris <jmorris@namei.org>,
	Russell King <rmk+kernel@arm.linux.org.uk>,
	Ingo Molnar <mingo@elte.hu>, Arnd Bergmann <arnd@arndb.de>,
	Jeff Dike <jdike@addtoit.com>, Anton Blanchard <anton@samba.org>,
	Thomas Gleixner <tglx@linutronix.de>, "Luck,
	Tony" <tony.luck@intel.com>, Ralf Baechle <ralf@linux-mips.org>,
	Kyle McMartin <kyle@mcmartin.ca>, Paul Mundt <lethal@linux-sh.org>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linuxppc-dev@lists.ozlabs.org, Al Viro <viro@zeniv.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Mon, 22 Mar 2010, Andreas Schwab wrote:
> 
> ipc/syscall.c:17: error: conflicting types for ¡sys_ipc¢
> include/linux/syscalls.h:691: note: previous declaration of ¡sys_ipc¢ was here

Hmm. Right you are. Why don't I see this? (I already applied the patch)

Ahh. Because this only triggers with __ARCH_WANT_SYS_IPC. But why didn't 
Anton see it then? 

Anyway, I assume the following fixes it. Can you verify?

		Linus

---
 include/linux/syscalls.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index f994ae5..057929b 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -688,7 +688,7 @@ asmlinkage long sys_shmat(int shmid, char __user *shmaddr, int shmflg);
 asmlinkage long sys_shmget(key_t key, size_t size, int flag);
 asmlinkage long sys_shmdt(char __user *shmaddr);
 asmlinkage long sys_shmctl(int shmid, int cmd, struct shmid_ds __user *buf);
-asmlinkage long sys_ipc(unsigned int call, int first, int second,
+asmlinkage long sys_ipc(unsigned int call, int first, unsigned long second,
 		unsigned long third, void __user *ptr, long fifth);
 
 asmlinkage long sys_mq_open(const char __user *name, int oflag, mode_t mode, struct mq_attr __user *attr);
