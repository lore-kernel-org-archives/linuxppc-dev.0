Return-Path: <srs0=3ajo=eu=infradead.org=rdunlap@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zRk0v1PNxzDrD7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jan 2018 11:48:15 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3zRk0t6dRHz8tBq
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jan 2018 11:48:14 +1100 (AEDT)
Subject: Re: [PATCH 5/5] powerpc/ftw: Document FTW API/usage
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, mikey@neuling.org,
 hbabu@us.ibm.com, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
References: <1516157443-17716-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1516157443-17716-6-git-send-email-sukadev@linux.vnet.ibm.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <57a1be39-df84-d678-7560-e2543824472d@infradead.org>
Date: Wed, 24 Jan 2018 16:48:03 -0800
MIME-Version: 1.0
In-Reply-To: <1516157443-17716-6-git-send-email-sukadev@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/16/2018 06:50 PM, Sukadev Bhattiprolu wrote:
> Document the usage of the VAS Fast thread-wakeup API and add an entry in
> MAINTAINERS file.
> 
> Thanks for input/comments from Benjamin Herrenschmidt, Michael Neuling,
> Michael Ellerman, Robert Blackmore, Ian Munsie, Haren Myneni and Paul
> Mackerras.
> 
> Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> ---
> 
> Changelog[v2]
> 	- [Michael Neuling] Update API to use a single, VAS_FTW_SEUTP ioctl
> 	  rather than two ioctls.
> 	- [Michael Neuling] Drop "nx" from name "nx-ftw".
> 
> ---
>  Documentation/powerpc/ftw-api.txt | 283 ++++++++++++++++++++++++++++++++++++++
>  MAINTAINERS                       |   8 ++
>  2 files changed, 291 insertions(+)
>  create mode 100644 Documentation/powerpc/ftw-api.txt
> 
> diff --git a/Documentation/powerpc/ftw-api.txt b/Documentation/powerpc/ftw-api.txt
> new file mode 100644
> index 0000000..a107628
> --- /dev/null
> +++ b/Documentation/powerpc/ftw-api.txt
> @@ -0,0 +1,283 @@
> +Virtual Accelerator Switchboard and Fast Thread-Wakeup API
> +
...
> +
> +    Application access to the FTW mechanism is provided through the FTW
> +    device node (/dev/ftw) implemented by the FTW device driver.
> +
> +    A multi-threaded software processes that intends to use the FTW

                                 process

> +    mechanism must first setup a channel (consisting of a pair of VAS
> +    windows) for the waiting and waking threads to communicate. The
> +    channel is set up by opening the FTW device and issuing the FTW_SETUP
> +    ioctl. Upon successful return from the ioctl, the waiting side of
> +    channel is complete and a thread can issue the "Wait" instruction
> +    to wait for an event.
> +
> +    After the successful return from the FTW_SETUP ioctl, the waking
> +    thread must use mmap() system call on the same file descriptor and
> +    obtain a virtual address known as the "paste address".
> +
> +    Once the mmap() call succeeds the setup of "waking" side of the channel
> +    is complete. To wake up a waiting thread, the waking thread should use
> +    the "COPY" and "PASTE" instructions to write a zero-filled CRB to the
> +    paste-address.
> +
> +    The wait and wake up operations can be repeated as long as the paste
> +    address and the FTW file descriptor are valid (i.e until munmap() of
> +    the paste address or a close() of the FTW fd).
> +
> +1. FTW Device Node
> +
> +    There is one /dev/ftw node in the system and it provides access to the
> +    VAS/FTW functionality.
> +
> +    The only valid operations (system calls) on the FTW node are:
> +
> +        - open() the device for read and write.
> +
> +        - issue the FTW_SETUP ioctl to set up a channel.
> +
> +        - mmap() the file descriptor
> +
> +        - close the device node.
> +
> +    Other file operations on the FTW node are undefined.
> +
> +    Note that the COPY and PASTE operations go directly to the hardware
> +    and do not involve system calls or go through the FTW device.
> +
> +    Although a system may have several instances of the VAS in the system
> +    (typically, one per P9 chip) there is just one FTW device node in
> +    the system.
> +
> +    When the FTW device node is opened, the kernel assigns a suitable
> +    instance of VAS to the process. Kernel will make a best-effort attempt
> +    to assign an optimal instance of VAS for the process - based on the CPU/
> +    chip that the process is running on. In the initial release, the kernel
> +    does not support migrating the VAS instance if the process migrates from
> +    a CPU on one chip to a CPU on another chip.
> +
> +    Applications may chose a specific instance of the VAS using the 'vas_id'

                        choose

> +    field in the FTW_SETUP ioctl as detailed below.
> +
> +2. Open FTW node
> +
> +    The device should be opened for read and write. No special privileges
> +    are needed to open the device. The device may be opened multiple times.
> +
> +    Each open() of the FTW device is associated with one channel of
> +    communication. There is a system-wide limit (currently 64K windows per
> +    chip and since some are reserved for hardware, there are about 32K
> +    channels per chip). If no more channels are available, the open() system
> +    call will fail.
> +
> +    See open(2) system call man pages for other details such as return
> +    values, error codes and restrictions.
> +
> +3. Setup a communication channel (FTW_SETUP ioctl)
> +
> +    A process that intends to use the Fast Thread-wakeup mechanism must
> +    first setup a channel by issuing the FTW_SETUP ioctl.
> +
> +        #include <misc/ftw.h>
> +
> +        struct ftw_setup_attr ftwattr;
> +
> +        rc = ioctl(fd, FTW_SETUP, &ftwattr);
> +
> +    The attributes of ftwattr are as follows:
> +
> +        struct ftw_setup_attr {
> +                int16_t       version;
> +                int16_t       vas_id;
> +                uint32_t      reserved;
> +
> +                int64_t       reserved1;
> +                int64_t       flags;
> +                int64_t       reserved2;
> +        };
> +
> +    The version field identifies the version of the API and must currently
> +    be set to 1.
> +
> +    The vas_id field identifies a specific instance of the VAS that the
> +    application wishes to access. See section on VAS ID below.
> +
> +    The reserved fields must all be set to zeroes.
> +
> +    The flags field specifies additional attributes to the channel. The
> +    only valid bit in the flags for Fast thread-wakeup usage are:
> +
> +        FTW_FLAGS_PIN_WINDOW    if set, indicates that the channel should be
> +                                pinned in cache. This flag is restricted
> +                                to privileged users. See Pinning windows
> +                                below.
> +
> +    All the other bits in the flags field must be set to 0.
> +
> +    Return value:
> +
> +    The FTW_SETUP ioctl returns 0 on success. On error, it returns -1
> +    and sets the errno variable to indicate the error.
> +
> +    Error codes:
> +
> +        EINVAL      version is invalid
> +
> +        EINVAL      vas_id is invalid
> +
> +        EINVAL      fd does not refer to a valid VAS device.
> +
> +        ENOSPC      System has too many active channels (windows) open,

s/,/./ or s/,//

> +
> +        EPERM       FTW_FLAGS_PIN_WINDOW is set in 'flags' field and process
> +                    is not privileged.
> +
> +        EINVAL      reserved fields are not set to 0.
> +
> +    See the ioctl(2) man page for more details, error codes and restrictions.
> +
> +4. mmap() FTW device fd
> +
> +    The mmap() system call for a FTW device fd returns a "paste address"
> +    that the application can use to COPY/PASTE a CRB to the waiting thread.
> +
> +        paste_addr = mmap(NULL, size, prot, flags, fd, offset);
> +
> +    Only restrictions on mmap for a FTW device fd are:
> +
> +        - size parameter should be one page size
> +
> +        - offset parameter should be 0ULL.
> +
> +    Refer to mmap(2) man page for additional details/restrictions.
> +
> +    In addition to the error conditions listed on the mmap(2) man page,
> +    mmap() can also fail with one of following error codes:
> +
> +        EINVAL      fd is not associated with an open channel (window)
> +                    (i.e mmap() does not follow a successful call to the
> +                    FTW_SETUP ioctl).
> +
> +        EINVAL      offset field is not 0ULL.
> +
> +
> +5. VAS ID
...
> +
> +6. COPY/PASTE operations:
> +
> +    Applications should use the COPY and PASTE instructions defined in
> +    the RFC to copy/paste the CRB. For VAS/FTW usage, the contents of
> +    CRB, are ignored and can be zero, but CRB should point to a valid buffer

       CRB are ignored                                                   buffer.

> +
> +7. Interrupt completion and signal handling
> +
> +    No VAS-specific signals will be generated to the application threads
> +    with the VAS/FTW usage.
> +
> +8. Example/Proposed usage of the VAS/FTW API
> +
> +    In the following example we use two threads that use the VAS/FTW API.
> +    Thread T1 sets up the channel and uses the WAIT instruction to wait for
> +    an event. Thread T2 uses copy/paste instructions to wake up T1.
> +    Note that the pthread_cond_wait() calls must be in a loop for spurious
> +    wake ups, but are simplified here.
> +
> +    Common interfaces:
> +
> +        static bool paste_done;
> +
> +        #define WAIT    .long (0x7C00003C)
> +
> +        static inline int do_wait(void)
> +        {
> +                __asm__ __volatile(stringify_in_c(WAIT)";");
> +        }
> +
> +        /*
> +         * Check if paste_done is true
> +         */
> +        static bool is_paste_done(void)
> +        {
> +                return __sync_bool_compare_and_swap(&paste_done, 1, 0);
> +
> +        }
> +
> +        /*
> +         * Set paste_done to true
> +         */
> +        static inline void set_paste_done(void)
> +        {
> +                __sync_bool_compare_and_swap(&paste_done, 0, 1);
> +        }
> +
> +
> +        int fd = -1;        // global, visible to both T1 and T2
> +
> +    Thread T1:
> +
> +        struct ftw_setup_attr ftwattr;
> +
> +        fd = open("/dev/ftw", O_RDWR);
> +
> +        memset(&rxattr, 0, sizeof(rxattr));

Is that supposed to be ftwattr (2x above)?

> +        ftwattr.version = 1;
> +        ftwattr.vas_id = -1;
> +
> +        rc = ioctl(fd, FTW_SETUP, &ftwattr);
> +
> +        /* Tell T2 that waiter side of channel is ready */
> +        pthread_cond_signal(&rx_win_ready);
> +
> +        /* Rx set up done */
> +
> +        /* later, wait for an event to occur */
> +
> +        while(!is_paste_done())
> +            do_wait();
> +
> +    Thread T2:
> +
> +        /* Wait for waiter side of channel to be set up first */
> +        pthread_cond_wait(&rx_win_ready);
> +
> +        prot = PROT_READ|PROT_WRITE;
> +        paste_addr = mmap(NULL, 4096, prot, MAP_SHARED, fd, 0ULL);
> +
> +        /* Tx setup done */
> +
> +        /* later ... */
> +
> +        set_paste_done();           /* ... event occurred */
> +        write_empty_crb(paste_addr); /* wake up T1 */


-- 
~Randy
