Message-ID: <001901c044d5$81a87e80$e76e61d5@InternetLink>
From: "epicom" <epicom@idecnet.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: A few bugfixes
Date: Thu, 2 Nov 2000 15:02:14 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


 I have found several bugs in versions 2.4.0-test*, I don't know if they
exist
in 2.2.* versions, but it is posible.



1- file arch/ppc/mm/fault.c, function va_to_phys:

>>  return(((unsigned long)(pte_val(*pte)) & PAGE_MASK) | (address &
~(PAGE_MASK-1)));

^^^^^^^^^^^^^

(PAGE_MASK-1) is buggy, it must be only PAGE_MASK to works correctly:
Perhaps the autor of this line was thinking in: (PAGE_SIZE-1)

>>  return(((unsigned long)(pte_val(*pte)) & PAGE_MASK) | (address &
~PAGE_MASK));

^^^^^^^^^



2- file arch/ppc/8xx_io/commproc.c, function m8xx_cpm_setbrg:

The formula to calculate the value for registers BRGC (Baud Rate Generators)
is incorrect:
>>  *bp = ((BRG_UART_CLK / rate) << 1) | CPM_BRG_EN;
                           ^^^^

reading motorola data books we can found that that formula must be:
>>  *bp = ((BRG_UART_CLK / rate - 1) << 1) | CPM_BRG_EN;
                           ^^^^^^^^

At low baudrates the differential is not significant, but I must use an
UART at 220.300Hz

You can read the chapter 20.4.3 in the MPC850 user's manual, chapter 21.4.3
in MPC860 user's manual, or chapter 16.3 in MPC8260 user's manual.



3- file arch/ppc/mm/init.c, function free_initrd_mem:

the code for that funcion is:

>>  for (; start < end; start += PAGE_SIZE) {
>>      ClearPageReserved(virt_to_page(start));
>>      set_page_count(virt_to_page(start), 1);
>>      free_page(start);
>>      totalram_pages++;
>>  }
>>  printk ("Freeing initrd memory: %ldk freed\n", (end - start) >> 10);


The problem is tha when the prink function is executed, the value for
'start' variable has been changed in the for-loop. The printk must be
executed before of the loop, or, to do the next one:

>>  unsigned long initrd_size= 0;
>>  for (; start < end; start += PAGE_SIZE) {
>>      ClearPageReserved(virt_to_page(start));
>>      set_page_count(virt_to_page(start), 1);
>>      free_page(start);
>>      totalram_pages++;
>>      initrd_size+= PAGE_SIZE;
>>  }
>>  printk ("Freeing initrd memory: %ldk freed\n", initrd_size >> 10);

The result, store in 'initrd_size' is more real that (end-start).




In the wish to have been useful to improve the PPC port of the linux kernel:


Luis Recuerda,


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
