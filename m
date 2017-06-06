Return-Path: <asarai@suse.de>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3whpkS2BhpzDq5j
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Jun 2017 21:05:20 +1000 (AEST)
Subject: Re: [PATCH v3 1/2] tty: add compat_ioctl callbacks
To: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jslaby@suse.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-alpha@vger.kernel.org,
 "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
 Parisc List <linux-parisc@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-sh@vger.kernel.org,
 sparclinux <sparclinux@vger.kernel.org>, linux-xtensa@linux-xtensa.org,
 linux-arch <linux-arch@vger.kernel.org>,
 Christian Brauner <christian.brauner@ubuntu.com>,
 Valentin Rothberg <vrothberg@suse.com>
References: <20170603135111.5444-1-asarai@suse.de>
 <20170603135111.5444-2-asarai@suse.de>
 <CAK8P3a3j4rB+iVX=a36csE6mX9iMRp14TS1UeePyFsjTKQyiZw@mail.gmail.com>
From: Aleksa Sarai <asarai@suse.de>
Message-ID: <6faa7b93-a355-f7ba-e5e9-12f2414ac695@suse.de>
Date: Tue, 6 Jun 2017 21:05:06 +1000
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3j4rB+iVX=a36csE6mX9iMRp14TS1UeePyFsjTKQyiZw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>> diff --git a/Makefile b/Makefile
>> index 470bd4d9513a..fb689286d83a 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -401,6 +401,7 @@ KBUILD_CFLAGS   := -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
>>                     -fno-strict-aliasing -fno-common \
>>                     -Werror-implicit-function-declaration \
>>                     -Wno-format-security \
>> +                  -Wno-error=int-in-bool-context \
>>                     -std=gnu89 $(call cc-option,-fno-PIE)
> 
> This  slipped in by accident I assume? It seems completely unrelated.

Yeah, I re-sent v4 with this removed immediately afterwards.

> 
>> diff --git a/drivers/tty/pty.c b/drivers/tty/pty.c
>> index 65799575c666..2a6bd9ae3f8b 100644
>> --- a/drivers/tty/pty.c
>> +++ b/drivers/tty/pty.c
>> @@ -481,6 +481,16 @@ static int pty_bsd_ioctl(struct tty_struct *tty,
>>          return -ENOIOCTLCMD;
>>   }
>>
>> +static long pty_bsd_compat_ioctl(struct tty_struct *tty,
>> +                                unsigned int cmd, unsigned long arg)
>> +{
>> +       /*
>> +        * PTY ioctls don't require any special translation between 32-bit and
>> +        * 64-bit userspace, they are already compatible.
>> +        */
>> +       return pty_bsd_ioctl(tty, cmd, arg);
>> +}
>> +
> 
> This looks correct but unnecessary, you can simply point both
> function pointers to the same function:

They have different types, since they have different return types:

int  (*ioctl)(struct tty_struct *tty,
	    unsigned int cmd, unsigned long arg);
long (*compat_ioctl)(struct tty_struct *tty,
		     unsigned int cmd, unsigned long arg);

If you like, I can change (*ioctl) to return longs as well, and then 
change all of the call-sites (since unlocked_ioctl also returns long).

-- 
Aleksa Sarai
Software Engineer (Containers)
SUSE Linux GmbH
https://www.cyphar.com/
