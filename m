Date: Fri, 5 Jan 2001 10:13:23 +0100
From: christophe barbe <christophe.barbe@inup.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: gcc, floating point and linux kernel module
Message-ID: <20010105101323.B9136@pc8.inup.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello,

I'm compiling a kernel module for the linux 2.2.18 on a PPC target (MPC750) with the following gcc :
gcc version egcs-2.91.66 19990314 (egcs-1.1.2 release)

The resulting object uses FPU opcode to do optimization for 64 bits variables. I've add at the end of this mail the command line to compile one of the object included in the module which uses FPU, the guilty part of the code and the generated asm.

It's a bad thing to use FPU in the kernel mode (under linux), so my question is is there a way to turn of FPU usage ?

Thanks,
Christophe

--------------------

gcc -I"required_include_path" -D__KERNEL__ -DMODULE -O -g -DDEBUG -Wall -Wstrict-prototypes -c dir.c -o dir.o

--------------------

STATIC int do_filldir(gfs_inode_t *dip, int64 *f_pos, void *dirent,
		      gfs_filldir_t filldir, osi_buf_t *bh, int index, uint64 leaf_no)
{
  gfs_dirent_t *dent;
  gfs_leaf_t *leaf = NULL;
  int type, len, error;
  gfs_dirent_t **sorted_dents; /* Entries from current dent are sorted and
				  run throught the filldir fxn */
  uint16 dent_no, cur_dent_no;
  uint32 entries = 0;
  /* variables used to calculate things for the linked leaves */
  osi_buf_t *leafbh;
  uint64 orig_leaf_no = leaf_no;           << -- here comes the problem

  type = gfs_dirent_first(bh, &dent);

...
    leaf_no = orig_leaf_no;                << -- here's why

...

  return 0;

}

--------------------

do_filldir:
.stabn 68,0,1281,.LM659-do_filldir
.LM659:
	stwu 1,-144(1)
	mflr 0
	mfcr 12
	stfd 31,136(1)
	stw 18,80(1)
	stw 19,84(1)
	stw 20,88(1)
	stw 21,92(1)
	stw 22,96(1)
	stw 23,100(1)
	stw 24,104(1)
	stw 25,108(1)
	stw 26,112(1)
	stw 27,116(1)
	stw 28,120(1)
	stw 29,124(1)
	stw 30,128(1)
	stw 31,132(1)
	stw 0,148(1)
	stw 12,76(1)
	mr 28,3
	mr 24,4
	mr 21,5
	mr 20,6
	mr 26,7
	mr 22,8
	mr 30,9
	mr 31,10
.stabn 68,0,1282,.LM660-do_filldir
.LM660:
.LBB115:
.stabn 68,0,1288,.LM661-do_filldir
.LM661:
	li 27,0
.stabn 68,0,1291,.LM662-do_filldir
.LM662:
	stw 30,48(1)
	stw 31,52(1)
	lfd 0,48(1)     << ------------------  FPU
	fmr 31,0        << ------------------  FPU
.stabn 68,0,1295,.LM663-do_filldir
.LM663:
	mr 3,26
	addi 4,1,20
	bl gfs_dirent_first
	mr 25,3

...

.L1011:
.stabn 68,0,1453,.LM749-do_filldir
.LM749:
.LBE115:
	lwz 0,148(1)
	lwz 12,76(1)
	mtlr 0
	lwz 18,80(1)
	lwz 19,84(1)
	lwz 20,88(1)
	lwz 21,92(1)
	lwz 22,96(1)
	lwz 23,100(1)
	lwz 24,104(1)
	lwz 25,108(1)
	lwz 26,112(1)
	lwz 27,116(1)
	lwz 28,120(1)
	lwz 29,124(1)
	lwz 30,128(1)
	lwz 31,132(1)
	lfd 31,136(1)  << - FPU : the variable is placed in a FP register
	mtcrf 32,12
	la 1,144(1)
	blr

--

Christophe Barbé
Software Engineer
Lineo High Availability Group
42-46, rue Médéric
92110 Clichy - France
phone (33).1.41.40.02.12
fax (33).1.41.40.02.01
www.lineo.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
