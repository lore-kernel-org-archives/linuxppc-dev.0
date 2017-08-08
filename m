Return-Path: <srs0=ev05=7k=linux.vnet.ibm.com=sukadev@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xRqn22S3CzDqrS
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Aug 2017 09:07:50 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3xRqn20ND2z8sxC
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Aug 2017 09:07:50 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3xRqn133Kxz9t2y
 for <linuxppc-dev@ozlabs.org>; Wed,  9 Aug 2017 09:07:49 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v78N7QFm070775
 for <linuxppc-dev@ozlabs.org>; Tue, 8 Aug 2017 19:07:47 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2c7jrecar2-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Tue, 08 Aug 2017 19:07:47 -0400
Received: from localhost
 by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Tue, 8 Aug 2017 19:07:46 -0400
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, mikey@neuling.org,
 stewart@linux.vnet.ibm.com, apopple@au1.ibm.com, hbabu@us.ibm.com,
 oohall@gmail.com, linuxppc-dev@ozlabs.org, <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 17/17] powerpc/vas: Document FTW API/usage
Date: Tue,  8 Aug 2017 16:07:02 -0700
In-Reply-To: <1502233622-9330-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1502233622-9330-1-git-send-email-sukadev@linux.vnet.ibm.com>
Message-Id: <1502233622-9330-18-git-send-email-sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Document the usage of the VAS Fast thread-wakeup API.

Thanks for input/comments from Benjamin Herrenschmidt, Michael Neuling,
Michael Ellerman, Robert Blackmore, Ian Munsie, Haren Myneni, Paul Mackerras.

Cc:Ian Munsie <imunsie@au1.ibm.com>
Cc:Paul Mackerras <paulus@ozlabs.org>
Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 Documentation/powerpc/ftw-api.txt | 373 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 373 insertions(+)
 create mode 100644 Documentation/powerpc/ftw-api.txt

diff --git a/Documentation/powerpc/ftw-api.txt b/Documentation/powerpc/ftw-api.txt
new file mode 100644
index 0000000..0b3f16f
--- /dev/null
+++ b/Documentation/powerpc/ftw-api.txt
@@ -0,0 +1,373 @@
+Virtual Accelerator Switchboard and Fast Thread-Wakeup API
+
+    Power9 processor supports a hardware subystem known as the Virtual
+    Accelerator Switchboard (VAS) which allows two entities in the Power9
+    system to efficiently exchange messages. Messages must be formatted as
+    Coprocessor Reqeust Blocks (CRB) and be submitted using the COPY/PASTE
+    instructions (new in Power9).
+
+    Usage of VAS depends on the entities exchanging the messages and
+    currently two usages have been identified.
+
+    First usage of VAS, referred to as VAS/NX involves a software thread
+    submitting data compression requests to a co-processor (hardware/nest
+    accelerator) aka NX engine. The API for this usage is described in the
+    VAS/NX API document.
+
+    Alternatively, VAS can be used by two software threads to efficiently
+    exchange messages. Initially, this mechanism is intended to wake up a
+    waiting thread quickly - i.e "fast thread wake-up (FTW)". This document
+    describes the user API for this VAS/FTW mechanism.
+
+    Application access to the FTW mechanism is provided through the NX-FTW
+    device node (/dev/crypto/nx-ftw) implemented by the VAS/FTW device
+    driver.
+
+    A software thread T1 that intends to wait for an event must first setup
+    a receive window, by opening the NX-FTW device and using the
+    VAS_RX_WIN_OPEN ioctl. Upon successful return from the VAS_RX_WIN_OPEN
+    ioctl, an rx_win_handle is returned.
+
+    A software thread T2 that intends to wake up T1 at some point, must first
+    set up a "send window" using the VAS_TX_WIN_OPEN ioctl and specify the
+    rx_win_handle obtained by T1. After a successful VAS_TX_WIN_OPEN ioctl the
+    send window of T2 is considered paired with the receive window of T1. The
+    thread T2 must then use mmap() to obtain a "paste address" for the send
+    window.
+
+    With this set up, thread T1 can wait for an event using the WAIT
+    instruction.
+
+    Thread T2 can wake up T1 by using the "COPY/PASTE" instructions and
+    submitting an empty/NULL CRB to the send window's paste address. The
+    wait/wake up process can be repeated as long as the threads have the
+    send/receive windows open.
+
+1. NX-FTW Device Node
+
+    There is one /dev/crypto/nx-ftw node in the system and it provides
+    access to the VAS/FTW functionality.
+
+    The only valid operations on the NX-FTW node are:
+
+        - open() the device for read and write.
+
+        - issue either VAS_RX_WIN_OPEN or VAS_TX_WIN_OPEN ioctls to set up
+          receive or send (only one of them per open).
+
+        - if the open is associated with send window (i.e VAS_TX_WIN_OPEN
+          ioctl was issued) mmap() the send window into the application's
+          virtual address space. (i.e get a 'paste_address' for the send
+          window).
+
+        - close the device node.
+
+    Other file operations on the NX-FTW node are undefined.
+
+    Note tHAT the COPY and PASTE operations go directly to the hardware
+    and not go through the NX-FTW device.
+
+    Although a system may have several instances of the VAS in the system
+    (typically, one per P9 chip) there is just one NX-FTW device node in
+    the system.
+
+	When the NX-FTW device node is opened, the kernel assigns a suitable
+	instance of VAS to the process. Kernel will make a best-effort attempt
+	to assign an optimal instance of VAS for the process. In the initial
+    release, the kernel does not support migrating the VAS instance if the
+    process migrates from a processor on one chip to a processor on another
+    chip.
+
+    Applications may chose a specific instance of the VAS using the 'vas_id'
+    field in the VAS_TX_WIN_OPEN and VAS_RX_WIN_OPEN ioctls as detailed below.
+
+2. Open NX-FTW node
+
+    The device should be opened for read and write. No special privileges
+    are needed to open the device. The device may be opened multiple times.
+
+    Each open() of the NX-FTW device may be associated with either a send
+    window or receive window but not both.
+
+    See open(2) system call man pages for other details such as return
+    values, error codes and restrictions.
+
+3. Setup Receive window (VAS_RX_WIN_OPEN ioctl)
+
+    A thread that expects to wait for events and be woken up using COPY/PASTE
+    must first set up a receive window by issuing the VAS_RX_WIN_OPEN ioctl.
+
+        #include <asm/vas.h>
+
+        struct vas_rx_win_open_attr rxattr;
+
+        rc = ioctl(fd, VAS_RX_WIN_OPEN, &rxattr);
+
+    The attributes of rxattr are as follows:
+
+        struct vas_rx_win_open_attr {
+                int16_t       version;
+                int16_t       vas_id;
+                int32_t       rx_win_handle;    /* output field */
+                int64_t       reserved[8];
+        };
+
+    The version field identifies the version of the API and must currently
+    be set to 1.
+
+    The vas_id field identifies a specific instance of the VAS that the
+    application wishes to access. See section on VAS ID below.
+
+    The reserved field must be set to all zeroes.
+
+    Upon successful return from the ioctl, the rx_win_handle field contains
+    an identifier for the VAS window associated with this "sleeping" thread.
+
+    This rx_win_handle field is used to "pair" this receive window with a
+    send window and must be specified when opening the corresponding send
+    window (see struct vas_tx_win_open_attr below).
+
+    Return value:
+
+    The VAS_RX_WIN_OPEN ioctl returns 0 on success. On error, it returns -1
+    and sets the errno variable to indicate the error.
+
+    Error codes:
+
+        EINVAL      version is invalid
+
+        EINVAL      vas_id is invalid
+
+        EINVAL      reserved field is not set to zeroes
+
+        EINVAL      fd is already associated with a send window
+
+
+3. Set up a Send window (VAS_TX_WIN_OPEN ioctl)
+
+    An application thread that expects to wake up a waiting thread using
+    copy/paste, must first set up a send window that is paired with the
+    receive window of the waiting thread. This is accomplished using the
+    VAS_TX_WIN_OPEN ioctl.
+
+        #include <asm/vas.h>
+
+        struct vas_tx_win_open_attr txattr;
+
+        rc = ioctl(fd, VAS_TX_WIN_OPEN, &txattr);
+
+    The attributes 'txattr' for the VAS_TX_WIN_OPEN ioctl are defined as
+    follows:
+
+        struct vas_tx_win_open_attr {
+            int32_t       version;
+            int16_t       vas_id;
+            uint32_t      rx_win_handle;
+
+            int64_t       reserved1;
+
+            int64_t       flags;
+            int64_t       reserved2;
+
+            int32_t       tc_mode;
+            int32_t       rsvd_txbuf;
+            int64_t       reserved3[6];
+        };
+
+    The version field must currently be set to 1.
+
+    The vas_id field identifies a specific instance of the VAS that the
+    application wishes to access. See section on VAS ID below.
+
+    The rx_win_handle field must be set to the rx_win_handle returned by
+    a prior successful call to VAS_RX_WIN_OPEN ioctl (see above). This
+    field is used to pair this send window with a receive window. The
+    process must have sufficient permissions to communicate with the
+    process owning the receive window identified by rx_win_handle.
+
+    The tc_mode and  rsvd_txbuf fields are currently unused and must be
+    set to 0
+
+    The flags field specifies additional attributes to the window. The
+    only valid bit in the flag are for FTW windows is:
+
+        VAS_FLAGS_PIN_WINDOW    if set, indicates the a window should be
+                                pinned in cache. This flag is restricted
+                                to privileged users. See Pinning windows
+                                below.
+
+    All the other bits in the flags field must be set to 0.
+
+    The fields reserved1, reserved2 and reserved3 are for future extension
+    and must be set to 0.
+
+    Return value:
+
+    The VAS_TX_WIN_OPEN ioctl returns 0 on success. On error, it returns -1
+    and sets the errno variable to indicate the error.
+
+    Error conditions:
+
+        EINVAL      version, vas_id or rx_win_handle fields are invalid
+
+        EINVAL      fd does not refer to a valid VAS device.
+
+        EINVAL      fd is already associated with a receive window
+
+        ENOSPC      System has too many active windows (connections) open,
+
+        EINVAL      For FTW windows, rsvd_txbuf is not 0.
+
+        EINVAL      For FTW windows, tc_mode is not VAS_THRESH_DISABLED.
+
+        EPERM       VAS_FLAGS_PIN_WINDOW is set in 'flags' field and process
+                    is not privileged.
+
+        EPERM       VAS_FLAGS_HIGH_PRI is set in 'flags' field and process
+                    is not privileged.
+
+        EINVAL      an invalid flag is set in the 'flags' field. (For FTW
+                    windows, VAS_FLAGS_HIGH_PRI is also invalid).
+
+        EINVAL      reserved fields are not set to 0.
+
+    See the ioctl(2) man page for more details, error codes and restrictions.
+
+4. mmap() NX-FTW device fd
+
+    The mmap() system call for a NX-FTW device fd returns a "paste address"
+    that the application can use to COPY/PASTE a CRB to the waiting thread.
+
+        paste_addr = mmap(NULL, size, prot, flags, fd, offset);
+
+    The mmap() operation is only valid on a file descriptor associated
+    with a send window.
+
+    Only restrictions on mmap for a NX-FTW device fd are:
+
+        - size parameter should be one page size
+
+        - offset parameter should be 0ULL.
+
+    Refer to mmap(2) man page for additional details/restrictions.
+
+    In addition to the error conditions listed on the mmap(2) man page,
+    mmap() can also fail with one of following error codes:
+
+        EINVAL      fd is not associated with an open send window (i.e mmap()
+                    does not follow a successful call to the VAS_TX_WIN_OPEN
+                    ioctl).
+
+        EINVAL      offset field is not 0ULL.
+
+
+5. VAS ID
+
+    A system may have several instances of VAS in the hardware, typically
+    one per POWER 9 chip. The choice of a specific instance of VAS can have
+    significant impact on the performance, specially if the application
+    migrates from one CPU to another. Applications can specify a vas_id
+    using the VAS_TX_WIN_OPEN and VAS_RX_WIN_OPEN ioctls and should be
+    prudent in choosing an instance of VAS.
+
+    The vas_id for each instance of VAS is listed as the device tree
+    property 'ibm,vas-id'. Determining the specific vas_id to use for
+    a specific application thread is beyond the scope of this API.
+
+    If the application has no preference, the vas_id field may be set to
+    -1 and the kernel will choose a suitable instance of the VAS engine.
+
+6. COPY/PASTE operations:
+
+    Applications should use the COPY and PASTE instructions defined in
+    the RFC to copy/paste the CRB. For VAS/FTW usage, the contents of
+    CRB if any, are ignored. CRB can be NULL.
+
+7. Interrupt completion and signal handling
+
+    No VAS-specific signals will be generated to the application threads
+    with the VAS/FTW usage.
+
+
+8. Example/Proposed usage of the VAS/FTW API
+
+    In the following example we use two threads that use the VAS/FTW API.
+    Thread T1 uses the WAIT instruction to wait for an event. Thread T2
+    uses copy/paste instructions to wake up T1.
+
+    Common interfaces:
+
+        static bool paste_done;
+        uint32_t rx_win_handle;
+
+        #define WAIT    .long (0x7C00003C)
+
+        static inline int do_wait(void)
+        {
+                __asm__ __volatile(stringify_in_c(WAIT)";");
+        }
+
+        /*
+         * Check if paste_done is true
+         */
+        static bool is_paste_done(void)
+        {
+                return __sync_bool_compare_and_swap(&paste_done, 1, 0);
+
+        }
+
+        /*
+         * Set paste_done to true
+         */
+        static inline void set_paste_done(void)
+        {
+                __sync_bool_compare_and_swap(&paste_done, 0, 1);
+        }
+
+    Thread T1:
+
+        struct vas_rx_win_open_attr rxattr;
+
+        fd = open("/dev/crypto/nx-ftw", O_RDWR);
+
+        memset(&rxattr, 0, sizeof(rxattr));
+        rxattr.version = 1;
+
+        rc = ioctl(fd, VAS_RX_WIN_OPEN, &rxattr);
+
+        rx_win_handle = rxattr.rx_win_handle;
+
+        /* Tell T2 that Rx window is ready to be paired */
+        pthread_cond_signal(&rx_win_ready);
+
+        /* Rx set up done */
+
+        /* later, wait for an event to occur */
+
+        while(!is_paste_done())
+            do_wait();
+
+    Thread T2:
+
+        struct vas_tx_win_open_attr txattr;
+
+        fd = open("/dev/crypto/nx-ftw", O_RDWR);
+
+        /* Wait for Rx window to be set up first */
+        pthread_cond_wait(&rx_win_ready);
+
+        memset(&txattr, 0, sizeof(txattr));
+        txattr.version = 1;
+        txattr.rx_win_handle = rx_win_handle;
+
+        rc = ioctl(fd, VAS_TX_WIN_OPEN, &txattr);
+
+        prot = PROT_READ|PROT_WRITE;
+        paste_addr = mmap(NULL, 4096, prot, MAP_SHARED, fd, 0ULL);
+
+        /* Tx setup done */
+
+        /* later ... */
+
+        set_paste_done();           /* ... event occured */
+        write_null_crb(paste_addr); /* wake up T1 */
-- 
2.7.4
