Date: Wed, 4 Feb 2004 11:12:49 +0100
From: Olaf Hering <olh@suse.de>
To: linuxppc-dev@lists.linuxppc.org
Subject: Video For Linux on ppc32 in kernel 2.6
Message-ID: <20040204101249.GA25776@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


CONFIG_VIDEO_DEV triggers CONFIG_VIDEO_BUF. If compiled as module,
video-buf.c wants clear_user_page(). This is a define on most archs
(maps to clear_page()), on ppc32 it is an unexported function. This
leads to unresolved symbols.

Should clear_user_page() be exported or should
drivers/media/video/video-buf.c:videobuf_vm_nopage() do something else
to achive similar results?

--
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
