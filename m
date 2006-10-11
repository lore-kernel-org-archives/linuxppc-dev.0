Return-Path: <lauri.ehrenpreis@liewenthal.ee>
Received: from HOT-Bounce1.hot.ee (mail.neti.ee [194.126.101.114])
	by ozlabs.org (Postfix) with ESMTP id 1D27B67B56
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 12 Oct 2006 00:42:42 +1000 (EST)
Received: from mail.neti.ee (Relay4 [192.168.1.23])
	by HOT-Bounce1.hot.ee (Postfix) with ESMTP id 6C6B8454382
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 11 Oct 2006 17:14:34 +0300 (EEST)
Received: from localhost (localhost [127.0.0.1])
	by MXR-4.estpak.ee (Postfix) with ESMTP id 3CFF71712D9
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 11 Oct 2006 17:14:31 +0300 (EEST)
Received: from mail.neti.ee ([127.0.0.1])
	by localhost (Relay4 [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 27888-07 for <linuxppc-embedded@ozlabs.org>;
	Wed, 11 Oct 2006 17:14:31 +0300 (EEST)
Received: from Relayhost2.neti.ee (Relayhost2 [192.168.1.102])
	by MXR-4.estpak.ee (Postfix) with ESMTP id 13602170FC9
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 11 Oct 2006 17:14:31 +0300 (EEST)
Received: from mail.liewenthal.ee (217-159-170-190-dsl.est.estpak.ee
	[217.159.170.190])
	by Relayhost2.neti.ee (Postfix) with ESMTP id 9F36438459
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 11 Oct 2006 17:14:30 +0300 (EEST)
Received: from laurie.liewenthal.ee ([10.10.10.32])
	by mail.liewenthal.ee with esmtp (Exim 4.50) id 1GXeqX-0000sy-Qu
	for linuxppc-embedded@ozlabs.org; Wed, 11 Oct 2006 17:14:09 +0300
Date: Wed, 11 Oct 2006 17:14:07 +0300
From: "Lauri Ehrenpreis" <lauri.ehrenpreis@liewenthal.ee>
To: linuxppc-embedded@ozlabs.org
Subject: Problems with DMA from user space on MPC834x (Cache coherency?)
Message-ID: <op.tg9ggdvees1gi5@laurie.liewenthal.ee>
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-13
MIME-Version: 1.0
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi!

I have a problem with DMA from user space on a platform powered by MPC834x
processor (which has powerpc e300 core inside). Our linux kernel version is
2.6.17.

My user space program does something like this:

file_fd = open("/disk/file", O_RDONLY);
result = read(file_fd, page_aligned_buf, len);
call_driver_ioctl_which_performs_dma();

while /disk is mounted to a partition residing on USB memory stick or SD  
card.
page_aligned_buf starts from page boundary and contains enough full pages  
for
the data (so I can allways map full page with dma_map_page in kernel).

The buffer address and data length will then be passed to a driver, which  
calls
get_user_pages, then maps each page with dma_map_page and tells a PCI  
device
to start reading from that page:

...
down_read(&current->mm->mmap_sem);
result = get_user_pages(current, current->mm, page_aligned_buf, nr_pages,  
0, 0, pages, NULL);
up_read(&current->mm->mmap_sem);

for (i = 0; i < nr_pages; i++) {
	find_data_checksum(pages[i]);
	dma_addr = dma_map_page(&fpga.pci_dev->dev, pages[i], 0, PAGE_SIZE,  
DMA_TO_DEVICE);

	start_dma();

	wait_until_dma_ready();

	dma_unmap_page(&fpga.pci_dev->dev, dma_addr, dma_len, DMA_TO_DEVICE);

	if(!checksum_ok_in_fpga())
		print_page_data();
}

for (i = 0; i < nr_pages; i++)
	page_cache_release(pages[i]);

The problem is that sometimes the PCI device receives wrong bytes at random
locations. I find the data checksum inside the driver and inside the FPGA.
Inside the driver I use kmap(page) and kunmap(page) to access data on the
user page. Sometimes the checksums do not match and I can see with the FPGA
debugging tool, that the FPGA receives different data than the driver is
printing out.

I have noticed 3 things regarding this error:
1) When I copy the data I read from the block device to another buffer in
userspace and pass this new buffer to the driver, then this error will
never occur:

file_fd = open("/disk/file", O_RDONLY);
result = read(file_fd, page_aligned_buf, len);
memcpy(new_page_aligned_buf, page_aligned_buf, len);
call_driver_ioctl_which_performs_dma(new_page_aligned_buf, len);

2) this error does not occur when I use copy_from_user instead of  
get_user_pages
and dma_map_page inside driver.

3) this error does not occur on our previuos device, which has x86  
platform.

I am currently out of ideas what to do next.. It seems to me like a cache
coherency problem. Can anyone suggest what might be wrong?

--
