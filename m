Message-ID: <3A648564.671DDDD5@tei.ericsson.se>
Date: Tue, 16 Jan 2001 18:31:17 +0100
From: Borlizzi Giacomo <giacomo.borlizzi@tei.ericsson.se>
MIME-Version: 1.0
To: "linuxppc-embedded@lists.linuxppc.org"
 <linuxppc-embedded@lists.linuxppc.org>,
        "Giacomo Borlizzi (TEI)" <giacomo.borlizzi@tei.ericsson.se>
Subject: KERNELBASE and MMU
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
I'm changing the operating system for my powerpc 860 board from
linux-2.2.13 to linux-2.4.0-test9.
With 2.2.13 version I have running the kernel and obtained the prompt of
sash .....
On 2.4 version it don't work instead.
My configuration foreseen  KERNELBASE set to 0x00000000 instead of
0xC0000000
this configuration seems be not  compatible with MMU initialization
code.
And infact during the execution of setup_arch() when the function
va_to_pte() is called
the  "mm = current->mm;" statment is executed (I report here some code)

pte_t *va_to_pte(unsigned long address)
{
 pgd_t *dir;
 pmd_t *pmd;
 pte_t *pte;
 struct mm_struct *mm;

 if (address < TASK_SIZE)           /* TASK_SIZE is 0x80000000 */
  mm = current->mm;                      <---this statment is executed
!!!
 else
  mm = &init_mm;

 dir = pgd_offset(mm, address & PAGE_MASK);
.......
.....

but at this moment "current" is not initialized????
on the 2.2.13 instead the function was have two parameters...

That is a big change... where I can found information on use of MMU on
860
and on means of those  data structures?

Thanks you in advanced and sorry for my bad English
/Giacomo Borlizzi


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
