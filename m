Reply-To: <joakim.tjernlund@lumentis.se>
From: "Joakim Tjernlund" <joakim.tjernlund@lumentis.se>
To: "Linuxppc-Dev@Lists. Linuxppc. Org (E-mail)" <linuxppc-dev@lists.linuxppc.org>
Subject: TASK_UNMAPPED_BASE
Date: Tue, 3 Feb 2004 14:05:20 +0100
Message-ID: <000501c3ea56$60935060$0a01a8c0@LUMENTIS02>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi All

Currently TASK_UNMAPPED_BASE in PPC is defined to:
#define TASK_UNMAPPED_BASE (TASK_SIZE / 8 *3) which is 0x30000000

in glibc ldso's JMP_SLOT you have:

      {
        Elf32_Sword delta = finaladdr - (Elf32_Word) reloc_addr;
        if (delta << 6 >> 6 == delta)
          *reloc_addr = OPCODE_B (delta);
        else if (finaladdr <= 0x01fffffc || finaladdr >= 0xfe000000)
          *reloc_addr = OPCODE_BA (finaladdr);
        else
          {
            Elf32_Word *plt, *data_words;
            Elf32_Word index, offset, num_plt_entries;

            plt = (Elf32_Word *) D_PTR (map, l_info[DT_PLTGOT]);
            offset = reloc_addr - plt;

            if (offset < PLT_DOUBLE_SIZE*2 + PLT_INITIAL_ENTRY_WORDS)
              {
                index = (offset - PLT_INITIAL_ENTRY_WORDS)/2;
                num_plt_entries = (map->l_info[DT_PLTRELSZ]->d_un.d_val
                                   / sizeof(Elf32_Rela));
                data_words = plt + PLT_DATA_START_WORDS (num_plt_entries);
                data_words[index] = finaladdr;
                reloc_addr[0] = OPCODE_LI (11, index * 4);
                reloc_addr[1] = OPCODE_B ((PLT_LONGBRANCH_ENTRY_WORDS
                                           - (offset+1))
                                          * 4);
                MODIFIED_CODE_NOQUEUE (reloc_addr + 1);
              }
            else
              {
                reloc_addr[0] = OPCODE_LIS_HI (12, finaladdr);
                reloc_addr[1] = OPCODE_ADDI (12, 12, finaladdr);
                reloc_addr[2] = OPCODE_MTCTR (12);
                reloc_addr[3] = OPCODE_BCTR ();
                MODIFIED_CODE_NOQUEUE (reloc_addr + 3);
              }
          }
      }
      break;

The if (delta << 6 >> 6 == delta) is commonly false.

If finaladdr is <= 0x01fffffc then the relocation is much cheaper than the last else statement.
But since TASK_UNMAPPED_BASE is 0x30000000, finaladdr will never be <= 0x01fffffc unless
a shared library asks for a low address.

I changed TASK_UNMAPPED_BASE to well under 0x01fffffc and it worked as well.

My question: Why is TASK_UNMAPPED_BASE=0x30000000 and would changing it to something
less, say 0x00100000 be a problem?

 Jocke

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
