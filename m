Date: Wed, 24 Mar 2004 15:25:24 +0100
From: Marc Leeman <marc.leeman@barco.com>
To: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: PCI Memory mapping
Message-ID: <20040324142524.GA22701@smtp.barco.com>
Reply-To: Marc Leeman <marc.leeman@barco.com>
References: <20040316114030.GB7133@smtp.barco.com> <1079455175.4184.25.camel@localhost.localdomain> <20040322074833.GY7133@smtp.barco.com> <20040323111736.GJ1446@smtp.barco.com> <1080086640.23208.164.camel@gaston> <20040324122652.GA22171@smtp.barco.com>
Mime-Version: 1.0
In-Reply-To: <20040324122652.GA22171@smtp.barco.com>
Content-Type: text/plain; charset=iso-8859-15
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is getting weird, I found a solution to the problem, well kind of.

Let's introduce the major players in this drama:

 /* communication struct between user and kernel space , in driver.h
  * kernel include */
 typedef struct SStreamPci {
         unsigned int pciaddress;
         unsigned int useraddress;
         unsigned char stream;
 }TSStreamPci;

 /* user space program */
 /* as long as not all data is transferred */
 while(userptr < (userbuffer + (TRANSFER_SIZE>>2))){
   /* currentstream is a struct that is passed to the kernel of
    * type TSStreamPci */
   currentstream.useraddress = (unsigned)userptr;

   /* copy our buffer to the kernel (PCI_TRANSFER_SIZE), 4k */
   ioctl(dsphandle,PPC2DSP_CONSISTENT_COPY_TO_KERNEL,&currentstream);

   /* Interrupt the DSP */
   WriteToDSP(PacketReady,0x1);
   ioctl(dsphandle,PPC2DSP_SET_HDCR,&interrupt);

   /* Wait until the DSP acknowledges transfer */
   while(ReadFromDSP(PacketReady)){}

   /* Read kernel buffer back */
   ioctl(dsphandle,PPC2DSP_CONSISTENT_COPY_FROM_KERNEL,&currentstream);

   /* increment pointer */
   userptr += (BLOCK_TRANSFER_SIZE >> 2);
 }

The strange thing is that this works only and only if I do a transfer
back from kernel space into the userbuffer AFTER the DSP has
acknowledged transferring the data. Note that this data is never used
again. Doing this copy_to_user before DSP acknowledgement still results
in the afore mentioned data corruption.

The associated ioctls are:
case PPC2DSP_CONSISTENT_COPY_TO_KERNEL:
  {
    TSStreamPci currentstream;
    if(copy_from_user(&currentstream,(TSStreamPci*) arg,sizeof(TSStreamPci))){
      return -EFAULT;
    }
    if(copy_from_user(driver_data.device[currentstream.stream]->kern_addr,(char*)currentstream.useraddress, PCI_TRANSFER_SIZE)){
      return -EFAULT;
    }
    break;
  }
case PPC2DSP_CONSISTENT_COPY_FROM_KERNEL:
  {
    TSStreamPci currentstream;
    if(copy_from_user(&currentstream,(TSStreamPci*) arg, sizeof(TSStreamPci))){
      return -EFAULT;
    }
    if(copy_to_user((char*)currentstream.useraddress,driver_data.device[currentstream.stream]->kern_addr, PCI_TRANSFER_SIZE)){
      return -EFAULT;
    }
    break;
  }

There is about a 10% bandwith reduction (due to PPC utilisation I would
assume) over the PCI, so I can live with that; but what bothers me is
not knowing _why_, ... Especially since I want my first module not to
contain too large beginners mistakes :)

  marc.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
