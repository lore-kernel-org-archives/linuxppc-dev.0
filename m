Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Date: Thu, 8 Nov 2001 09:37:02 -0800
Subject: Re: 405 -- a little console help, part 2
Content-Type: multipart/mixed; boundary=Apple-Mail-2--983465287
Mime-Version: 1.0 (Apple Message framework v472)
Cc: linuxppc-embedded@lists.linuxppc.org
To: Mark Pilon <mpilon@midrivers.com>
From: Scott Anderson <scott_anderson@mvista.com>
In-Reply-To: <3BEA8A5D.50A75CE7@midrivers.com>
Message-Id: <37E0A601-D46F-11D5-B1B0-003065F489CE@mvista.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--Apple-Mail-2--983465287
Content-Disposition: attachment;
	filename=.gdbinit
Content-Transfer-Encoding: 7bit
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name=".gdbinit"

set output-radix 16

define task_struct_header
  printf "Address      pid ST device comm\n"
end

define task_struct_show
  printf "0x%08X %5d %2d ", $arg0, $arg0->pid, $arg0->state
  if ($arg0->tty)
    printf "0x%04X ", $arg0->tty->device
  else
    printf "       "
  end
  printf "%s\n", $arg0->comm
end

define ps
  task_struct_header
  task_struct_show current
  set $t=current->next_task
  while current!=$t
    task_struct_show $t
    set $t=$t->next_task
  end
end
document ps
Print points of interest for all tasks starting at current
end

define task
  task_struct_header
  set $t=(struct task_struct *)$arg0
  task_struct_show $t
end
document task
Print points of interest for the given task_struct
end

define maps
  set $t=(struct task_struct *)$arg0
  if ($t->mm)
    set $m=$t->mm->mmap
    while ($m != 0)
      printf "0x%08X 0x%08X ", $m->vm_start, $m->vm_end
      printf "%c", ($m->vm_flags & 0x01) ? 'r' : '-'
      printf "%c", ($m->vm_flags & 0x02) ? 'w' : '-'
      printf "%c", ($m->vm_flags & 0x04) ? 'x' : '-'
      printf "%c", ($m->vm_flags & 0x80) ? 's' : 'p'
      if ($m->vm_file && $m->vm_file->f_dentry)
        printf " %s", $m->vm_file->f_dentry->d_name.name
      end
      printf "\n"
      set $m=$m->vm_next
    end
  else
    printf "No mm for task\n"
  end
end
document maps
Print the address map for a given task_struct (ala /proc/<pid>/maps)
end

define pgdir
  printf "Virtual    Physical   Flags\n"
  set $t=(struct task_struct *)$arg0
  if ($t->thread)
    set $i=0
    set $pgdir=(unsigned long **)$t->thread.pgdir
    while ($i < 1024)
      if (*$pgdir)
        set $j=0
        set $pte=(unsigned long *)*$pgdir
        while ($j < 1024)
# To see all non-zero entries
#          if (*$pte)
# To see _PAGE_PRESENT entries on PPC 4xx
          if (*$pte & 0x20)
# To see _PAGE_PRESENT entries on PPC non-4xx
#          if (*$pte & 0x1)
            printf "0x%08X 0x%08X 0x%03X\n", ($i<<22)|($j<<12), *$pte&~0xFFF, *$pte&0xFFF
          end
          set $j=$j+1
          set $pte=$pte+1
        end
      end
      set $i=$i+1
      set $pgdir=$pgdir+1
    end
  end
end
document pgdir
Print the virtual to physical mappings for a given task_struct's memory
end

define phys
  set $t=(struct task_struct *)$arg0
  set $virt=(unsigned long)$arg1
  set $pgdir=(unsigned long **)$t->thread.pgdir + ($virt>>22)
  if (*$pgdir != 0)
    set $pte=(unsigned long *)*$pgdir + (($virt>>12)&0x3FF)
    if (*$pte != 0)
      printf "0x%08X 0x%03X\n", (*$pte&(~0xFFF))|($virt&0xFFF), *$pte&0xFFF
    else
      printf "No pte for given address\n"
    end
  else
    printf "No pgdir for given address\n"
  end
end
document phys
Print the physical address and PTE flags for a given task/address
end

define nip
  set $t=(struct task_struct *)$arg0
  printf "NIP=0x%08X\n", $t->thread.regs.nip
  if ($t->mm)
    set $m=$t->mm->mmap
    while ($m != 0)
      if ($m->vm_start < $t->thread.regs.nip && $t->thread.regs.nip < $m->vm_end)
        printf "section: 0x%08X 0x%08X ", $m->vm_start, $m->vm_end
        printf "%c", ($m->vm_flags & 0x01) ? 'r' : '-'
        printf "%c", ($m->vm_flags & 0x02) ? 'w' : '-'
        printf "%c", ($m->vm_flags & 0x04) ? 'x' : '-'
        printf "%c", ($m->vm_flags & 0x80) ? 's' : 'p'
        if ($m->vm_file && $m->vm_file->f_dentry)
          printf " %s", $m->vm_file->f_dentry->d_name.name
        end
	printf "\noffset=0x%08X\n", $t->thread.regs.nip - $m->vm_start
        set $m=0
      else
        set $m=$m->vm_next
      end
    end
  else
    printf "No mm for task\n"
  end
end
document nip
Print the next instruction pointer and offset within a
memory mapping for a given task_struct
end

define sp
  set $t=(struct task_struct *)$arg0
  printf "SP(R1)=0x%08X\n", $t->thread.regs.gpr[1]
  if ($t->mm)
    set $m=$t->mm->mmap
    while ($m != 0)
      if ($m->vm_start < $t->thread.regs.gpr[1] && $t->thread.regs.gpr[1] < $m->vm_end)
        printf "section: 0x%08X 0x%08X ", $m->vm_start, $m->vm_end
        printf "%c", ($m->vm_flags & 0x01) ? 'r' : '-'
        printf "%c", ($m->vm_flags & 0x02) ? 'w' : '-'
        printf "%c", ($m->vm_flags & 0x04) ? 'x' : '-'
        printf "%c", ($m->vm_flags & 0x80) ? 's' : 'p'
        if ($m->vm_file && $m->vm_file->f_dentry)
          printf " %s", $m->vm_file->f_dentry->d_name.name
        end
	printf "\noffset=0x%08X\n", $t->thread.regs.gpr[1] - $m->vm_start
        set $m=0
      else
        set $m=$m->vm_next
      end
    end
  else
    printf "No mm for task\n"
  end
end
document sp
Print the stack pointer and offset within a memory mapping
for a given task_struct
end

define kbt
  set $t=(struct task_struct *)$arg0
  set $last_ksp=$t
  set $ksp=$t->thread.ksp
  while ($ksp > $last_ksp && $ksp < $t+8192)
    printf "0x%08X: ", $ksp
    if (*($ksp+4) > 0xC0000000)
      x/1i *($ksp+4)
#      list **($ksp+4)
    else
      printf "0x%08X\n", *($ksp+4)
    end
    set $ksp=*$ksp
  end
end
document kbt
Print the backtrace of a given task_struct's kernel stack
end

--Apple-Mail-2--983465287
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed


On Thursday, November 8, 2001, at 05:36  AM, Mark Pilon wrote:
 >  I'll try poking
 > around w/ gdb/abatron but am not sure how to find the exec'd shell.

I hacked up some user defined functions in gdb to let me do ps
and some other things that I found useful for kernel debugging.
I've attached my .gdbinit so you can see what I did.  Warning:
there are some processor specific bits in some of the functions,
but the ps function "should just work".

   Scott Anderson


--Apple-Mail-2--983465287--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
