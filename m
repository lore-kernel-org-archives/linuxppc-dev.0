Message-ID: <001701c2e8d0$a017ef80$370da8c0@aman>
From: "Aman" <aman@mistralsoftware.com>
To: "linuxppc embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: Memory Leak
Date: Thu, 13 Mar 2003 01:20:25 +0530
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0014_01C2E8FE.B9BAA7B0"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.

------=_NextPart_000_0014_01C2E8FE.B9BAA7B0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

 Hi All
 I am using consistent_alloc () to allocate consistent memory for DMA.  When
I free the buffers using consistent_free(), the /proc/meminfo shows a
memory leak of the buffer size allocated.

 I have attached a  module code to allocate memory when inserted and free
 when removed. The memory leak can be found using the command cat
/proc/meminfo.

 Also the consistent_alloc call gives an error something like "Kernel bug at
cachemap.." if we try to allocate more than 2MB.

Can anyone help me in solving these issues

Thanking you in advance
Regards
Aman




------=_NextPart_000_0014_01C2E8FE.B9BAA7B0
Content-Type: application/octet-stream;
	name="alloc_test.c"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="alloc_test.c"

#define __NO_VERSION__=0A=
#include <linux/module.h>=0A=
#include <linux/version.h>=0A=
#include <linux/init.h>=0A=
#include <linux/kernel.h>=0A=
#include <linux/fs.h>=0A=
#include <linux/slab.h>=0A=
#include <linux/sched.h>=0A=
#include <linux/ioctl.h>=0A=
#include <linux/proc_fs.h>=0A=
#include <linux/wrapper.h>=0A=
#include <asm/io.h>=0A=
=0A=
=0A=
typedef int sint32_t;=0A=
=0A=
char kernel_version[]=3D UTS_RELEASE;=0A=
=0A=
uint8_t        *pu8_buffer;=0A=
=0A=
int init_module (void)=0A=
{=0A=
    dma_addr_t      str_phys_addr;=0A=
=0A=
    printk ("Init module\n");=0A=
=0A=
    pu8_buffer =3D consistent_alloc (GFP_KERNEL, 0x200000, =
&str_phys_addr);=0A=
=0A=
    if (pu8_buffer =3D=3D NULL)=0A=
    {=0A=
        printk ("Could not allocate memory\n");=0A=
=0A=
        return 0;=0A=
    }=0A=
=0A=
    printk ("Physical address =3D 0x%x\n", str_phys_addr);=0A=
    printk ("Virtual address =3D 0x%x\n", (uint32_t) pu8_buffer);=0A=
=0A=
    return 0;=0A=
}=0A=
=0A=
void cleanup_module (void)=0A=
{=0A=
    printk ("Freeing )x%x\n", (uint32_t) pu8_buffer);=0A=
=0A=
    consistent_free (pu8_buffer);=0A=
=0A=
    return;=0A=
}=0A=

------=_NextPart_000_0014_01C2E8FE.B9BAA7B0--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
