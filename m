Return-Path: <stbohne@googlemail.com>
Received: from mail-yw0-f172.google.com (mail-yw0-f172.google.com
	[209.85.211.172])
	by bilbo.ozlabs.org (Postfix) with ESMTP id BC34EB6EDF
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  4 Aug 2009 16:06:06 +1000 (EST)
Received: by ywh2 with SMTP id 2so9987642ywh.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 03 Aug 2009 23:06:04 -0700 (PDT)
MIME-Version: 1.0
Sender: stbohne@googlemail.com
Date: Tue, 4 Aug 2009 08:06:03 +0200
Message-ID: <c42b3320908032306y51770c97lb8e5769dd3ecbdb9@mail.gmail.com>
Subject: Memory mapped IO and Direct File IO
From: Stefan Bohne <Stefan.Bohne@senTec-Elektronik.de>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Greetings, everyone,

I'm trying to save some data block from a memory mapped device into a
file - real fast, i.e., without any copying.

My approach so far was to get a pointer to the io memory via mmap-ing
/dev/mem, and then writing this pointer to a file (in user space).
This works, if I don't use O_DIRECT, but this is slow of course. Using
O_DIRECT, write returns EFAULT (bad address). Coyping the data to a
user-space buffer and then writing with O_DIRECT works, though.

I tracked this down to __get_user_pages in mm/memory.c where IO pages
are refused. And this is as deep as my current knowledge allows me to
go into the kernel. I don't understand why IO pointers are not
allowed.

Ultra-Fast disk IO is a requirement for our project, so any copying in
between is not an option. Any hint is appreciated.

Stefan
