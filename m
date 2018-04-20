Return-Path: <arndbergmann@gmail.com>
Received: from mail-qk0-x244.google.com (mail-qk0-x244.google.com
 [IPv6:2607:f8b0:400d:c09::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40S7X35PmnzDqyL
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Apr 2018 17:58:27 +1000 (AEST)
Received: by mail-qk0-x244.google.com with SMTP id b131so3770971qkg.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Apr 2018 00:58:27 -0700 (PDT)
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <20180420075407.GA7119@osiris>
References: <20180419143737.606138-1-arnd@arndb.de>
 <20180419143737.606138-5-arnd@arndb.de>
 <20180420075407.GA7119@osiris>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 20 Apr 2018 09:58:24 +0200
Message-ID: <CAK8P3a1_TLs=QZuMVbbAGMEct+SBg2wZ663Kq2RJN5mgU1ZCtw@mail.gmail.com>
Subject: Re: [PATCH v3 04/17] y2038: s390: Remove unneeded ipc uapi header
 files
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: y2038 Mailman List <y2038@lists.linaro.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux API <linux-api@vger.kernel.org>,
 linux-arch <linux-arch@vger.kernel.org>,
 GNU C Library <libc-alpha@sourceware.org>,
 Thomas Gleixner <tglx@linutronix.de>, Deepa Dinamani <deepa.kernel@gmail.com>,
 Al Viro <viro@zeniv.linux.org.uk>, "Eric W . Biederman" <ebiederm@xmission.com>,
 Albert ARIBAUD <albert.aribaud@3adev.fr>,
 linux-s390 <linux-s390@vger.kernel.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 "the arch/x86 maintainers" <x86@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
 James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 sparclinux <sparclinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Apr 20, 2018 at 9:54 AM, Heiko Carstens
<heiko.carstens@de.ibm.com> wrote:
> On Thu, Apr 19, 2018 at 04:37:24PM +0200, Arnd Bergmann wrote:
>> The s390 msgbuf/sembuf/shmbuf header files are all identical to the
>> version from asm-generic.
>>
>> This patch removes the files and replaces them with 'generic-y'
>> statements, to avoid having to modify each copy when we extend sysvipc
>> to deal with 64-bit time_t in 32-bit user space.
>>
>> Note that unlike alpha and ia64, the ipcbuf.h header file is slightly
>> different here, so I'm leaving the private copy.
>>
>> To deal with 32-bit compat tasks, we also have to adapt the definitions
>> of compat_{shm,sem,msg}id_ds to match the changes to the respective
>> asm-generic files.
>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>>  arch/s390/include/asm/compat.h      | 32 ++++++++++++------------
>>  arch/s390/include/uapi/asm/Kbuild   |  3 +++
>>  arch/s390/include/uapi/asm/msgbuf.h | 38 ----------------------------
>>  arch/s390/include/uapi/asm/sembuf.h | 30 -----------------------
>>  arch/s390/include/uapi/asm/shmbuf.h | 49 -------------------------------------
>>  5 files changed, 19 insertions(+), 133 deletions(-)
>>  delete mode 100644 arch/s390/include/uapi/asm/msgbuf.h
>>  delete mode 100644 arch/s390/include/uapi/asm/sembuf.h
>>  delete mode 100644 arch/s390/include/uapi/asm/shmbuf.h
>
> FWIW,
>
> Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>

Thanks, added to the patch.

     Arnd
