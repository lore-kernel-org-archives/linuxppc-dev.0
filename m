Return-Path: <sprasad@bivio.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: ramdisk - how does the initial programs execute
Date: Thu, 19 Apr 2007 14:58:09 -0700
Message-ID: <D83235F0F3C86D4D889D8B9A0DA8C6D762C64B@corpexc01.corp.networkrobots.com>
From: "Siva Prasad" <sprasad@bivio.net>
To: <linuxppc-dev@ozlabs.org>,
	<linuxppc-embedded@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I am interested in knowing how the initial programs like "/init" works
when using the ramdisk (or any other file system for that matter).

Especially, when it starts do execve for an init program, I am more
interested in how the bss_start and bss_end is identified, and more
importantly how __clear_user with addresses in range of 0x0FFXXXXX work,
even when all the memory is mapped at 0xC0000000. Shouldn't __clear_user
throw an exception, as there is no BAT that can identify the effective
address it is trying to clear?

* How does stwu instruction (of __clear_user) successfully stores 0x0
into that address.
* Since it is a user level program, how come its address falls into
0x0FFXXXXX?. Should it be loaded dynamically at any address that is
given by kernel (> 0xC0000000)?

Thanks
Siva
