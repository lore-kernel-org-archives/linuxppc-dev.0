Message-ID: <3BE6E477.1090508@mvista.com>
Date: Mon, 05 Nov 2001 14:11:51 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Ofer Rashuk <OferR@Radlan.co.il>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: virtual memory issue
References: <42AB6BE23C29D511831E0002B32024881999FF@messenger.radlan.co.il>
Content-Type: text/plain; charset=windows-1255; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Ofer Rashuk wrote:


> my question is who can i translate the virtual address to a physical one.

You can't from a user program, nor do you want to do this.  Using
mmap() to physical devices from a user application must be done
with great care, and is often used just for debugging purposes.  There
are resources used by the kernel and other applications that cause
race conditions you can't control.

If you need access to physical memory for any reason, you must
write a kernel device driver for this device so you can properly
manage the resources necessary to ensure proper system operation.

Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
