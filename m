From: iweiny@pacbell.net
Date: Wed, 01 Dec 1999 16:46:42 -0800 (PST)
Subject: USB mouse module
To: linuxppc-dev@lists.linuxppc.org (linuxdev)
Message-id: <199912020046.QAA00675@batcave2.localdomain>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


OK,

>From Paul's rsync'ed tree I have the USB source and am compiling as a module.

Unfortunately I don't have my Linux device driver book anymore so I am asking a
basic question.

When mouse.o is inserted in the kernel the following gets called.

   um = (struct usb_mouse *) kmalloc(sizeof(*um), GFP_ATOMIC);

Eventually when mouse is removed from the kernel the following causes a kernel
panic.

      kfree(um);

YES I have checked to make sure they are pointing at the same place in fact
here are the messages I have used in the kernel.

Starting:
 kernel: USB mouse found
 kernel: IKW returning usb_mouse um =
 kernel:    um = c5e94700; um->dev = c9e4e120; um->irq_handle = 00000000
 kernel:    um->bEndpointAddress = ~A; um->bInterval = 10
 kernel:    um->mouse = cc86bed4; &(um->list) = c5e94700
 kernel:    um->list.prev = cc86bef8; um->list.next = cc86bef8
 kernel: usbcore: mouse driver claimed interface c5e94280

Stopping:
 kernel: USB Mouse disconnect started... 
 kernel: IKW um details 
 kernel:    um = c5e94700; um->irq_handle = 00000000; um->dev = c9e4e120
 kernel:    um->bEndpointAddress = ~A; &(um->list) = c5e94700
 kernel: IKW after deletes: um = c5e94700; &(um->list) = c5e94700; &um->list = c5e94700
 kernel: IKW um->list.prev = cc86bef8; um->list.next = cc86bef8 
 kernel: kmem_free: Bad obj addr (objp=c5e94700, name=size-32)
Kernel panic blah blah...

and usb_mouse looks like this.

struct usb_mouse {
   struct list_head list;
   struct usb_device *dev;  /* host controller this mouse is on */
   void* irq_handle;  /* host controller's IRQ transfer handle */
   __u8 bEndpointAddress;  /* these are from the endpoint descriptor */
   __u8 bInterval;      /* ...  used when calling usb_request_irq */
   struct mouse_state *mouse;
};

Does GFP_ATOMIC mean the memory is not "freeable" or relocatable?  (or
something?)

Sorry about such a pathetic question but I am playing around with USB and would
like to be able to load and unload the USB as I alter the code.  Eventually,
and for most, this may be a mute point since they will never "unload" their
mouse driver but for me I don't want to just comment out the kfree and have to
reboot as the driver eats up memory.  (every malloc should have a free right?)

Thanks
Ira Weiny
iweiny@acm.org


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
