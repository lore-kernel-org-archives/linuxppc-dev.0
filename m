Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
From: "S. Hebbar" <shebbar@india.tejasnetworks.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: JFFS2 crash
Date: Fri, 19 Mar 2004 08:21:19 +0530
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200403181020.42018.shebbar@india.tejasnetworks.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I am getting the following exception in the jffs2 module when the linux is
starting up.

The /etc partition is jffs2 file system. I verified the content of the flash
after programming and that matches with the original /etc binary image.
(Created using mkfs.jffs2 utility).

I can reproduce this problem very easily by editing one of the file
in /etc and give "reboot" command.
The /etc partition size is 1 Meg.TEJAS
> df
Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/mtdblock4            1024       804       220  79% /etc


Linux: Denx 2.4.20
UBoot: 0.3.0

The "map" is included at the end of this mail.

Any help is appreciated.

Regards,
Hebbar.


Mounting /dev/mtdblock4 on /etc as jffs2 file system.
init started:  BusyBox v0.60.5 (2004.03.04-09:24+0000) multi-call
                        Welcome to Linux
                Press 'I' to enter interactive startup.
Mounting proc filesystem on /proc [  OK  ]
Mounting tmpfs filesystem on /var [  OK  ]
Making a writable /dev [  OK  ]
Mounting devpts filesystem on /dev/pts [  OK  ]
Starting mountfs:  [  OK  ]
Oops: kernel access of bad area, sig: 11
NIP: C008D040 XER: 00000000 LR: C0091B8C SP: C73C3DE0 REGS: c73c3d30 TRAP:
0300
   Not tainted
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 39E51670, DSISR: 20000000
TASK = c73c2000[50] 'S10network' Last syscall: 3
last math c73c2000 last altivec 00000000
GPR00: 00000018 C73C3DE0 C73C2000 00000006 C730F000 00000632 00001000 00001000
GPR08: 030077F2 39E51658 00000006 C73FC000 00100000 100B0734 00000000 00000000
GPR16: 100D9B10 00000000 00000000 C00280A4 00000001 C018D6C0 00000000 C01990C4
GPR24: C73C3DF8 C730F000 00001000 C03934B0 C73FC000 C730F000 00000000 C0390100
Call backtrace:
C0091708 C0091B8C C0091D70 C008FE98 C008FF2C C008FFA0 C0027C6C
C00281FC C0035FF0 C0003F5C 10054164 10054524 1005B8CC 10022F8C
10023780 10022BDC 1001F304 1001EB88 10013564 100111E8 0FE88F70
00000000
/etc/rc.d/rc: line 125:    50 Segmentation fault      $i start



>From the mapfile:
=============
c008cfa8 T jffs2_compress
c008d00c T jffs2_decompress
c008d0e0 t init_rubin
c008d11c t encode
c008d27c t end_rubin
c008d310 t init_decode
c008d3a0 t __do_decode
c008d42c t decode
c008d4f0 t out_byte
c008d58c t in_byte
c008d5f8 t rubin_do_compress
c008d6d0 T jffs2_dynrubin_compress
c008d920 t rubin_do_decompress
c008d994 T jffs2_rubinmips_decompress
c008d9d4 T jffs2_dynrubin_decompress
c008da38 T jffs2_rtime_compress
c008db54 T jffs2_rtime_decompress
c008dc18 T jffs2_zlib_exit
c008dc4c T jffs2_zlib_compress
c008de6c T jffs2_zlib_decompress
c008e018 t jffs2_lookup
c008e17c t jffs2_readdir
c008e304 t jffs2_create
c008e42c t jffs2_unlink
c008e490 t jffs2_link
c008e5b0 t jffs2_symlink
c008ead0 t jffs2_mkdir
c008ef28 t jffs2_rmdir
c008ef9c t jffs2_mknod
c008f4a8 t jffs2_rename
c008f780 T jffs2_fsync
c008f854 T jffs2_setattr
c008fdfc T jffs2_do_readpage_nolock
c008ff14 T jffs2_do_readpage_unlock
c008ff50 T jffs2_readpage
c008ffdc T jffs2_prepare_write
c0090324 T jffs2_commit_write
c009053c T jffs2_ioctl
c0090544 T jffs2_add_fd_to_list
c009062c T jffs2_add_tn_to_list
c0090674 t jffs2_free_tmp_dnode_info_list
c00906c0 t jffs2_free_full_dirent_list
c0090700 T jffs2_get_inode_nodes
c0091148 T jffs2_set_inocache_state
c0091178 T jffs2_get_ino_cache
c00911c0 T jffs2_add_ino_cache
c0091214 T jffs2_del_ino_cache
c0091260 T jffs2_free_ino_caches
c00912cc T jffs2_free_raw_node_refs
c0091358 T jffs2_lookup_node_frag
c00913b4 T jffs2_kill_fragtree
c009148c T jffs2_fragtree_insert
c00913b4 T jffs2_kill_fragtree
c009148c T jffs2_fragtree_insert
c009154c T jffs2_destroy_slab_caches
c00915f4 T jffs2_alloc_full_dirent
c009161c T jffs2_free_full_dirent
c009163c T jffs2_alloc_full_dnode
c0091668 T jffs2_free_full_dnode
c0091694 T jffs2_alloc_raw_dirent
c00916c0 T jffs2_free_raw_dirent
c00916ec T jffs2_alloc_raw_inode
c0091718 T jffs2_free_raw_inode
c0091744 T jffs2_alloc_tmp_dnode_info
c0091770 T jffs2_free_tmp_dnode_info
c009179c T jffs2_alloc_raw_node_ref
c00917c8 T jffs2_free_raw_node_ref
c00917f4 T jffs2_alloc_node_frag
c0091820 T jffs2_free_node_frag
c009184c T jffs2_alloc_inode_cache
c0091878 T jffs2_free_inode_cache
c00918a4 T jffs2_read_dnode
c0091c1c T jffs2_read_inode_range
c0091dc4 T jffs2_getlink
c0091ef8 T jffs2_reserve_space
c00920a0 T jffs2_reserve_space_gc
c00920f4 t jffs2_do_reserve_space
c009243c T jffs2_add_physical_node_ref
c0092698 T jffs2_complete_reservation
c00926e4 T jffs2_mark_node_obsolete
c0092be0 t jffs2_obsolete_node_frag
c0092c5c T jffs2_add_full_dnode_to_inode
c0092d80 t jffs2_add_frag_to_fragtree
c0093140 T jffs2_truncate_fraglist
c0093204 T jffs2_do_read_inode
c00933c8 T jffs2_do_crccheck_inode
c009348c t jffs2_do_read_inode_internal
c0093974 T jffs2_do_clear_inode
c0093acc T jffs2_do_new_inode
c0093bf0 T jffs2_write_dnode
c0093e44 T jffs2_write_dirent
c0094080 T jffs2_write_inode_range
c00943fc T jffs2_do_create
c00947a0 T jffs2_do_unlink
c0094aa4 T jffs2_do_link
c0094cf0 T jffs2_scan_medium
c0095248 t jffs2_fill_scan_buf
c00952b4 t jffs2_scan_eraseblock
c0095c24 t jffs2_scan_make_ino_cache
c0095cb0 t jffs2_scan_inode_node
c0095e74 t jffs2_scan_dirent_node
c0096184 t count_list
c00961bc t rotate_list
c009620c T jffs2_rotate_lists
c0096344 t jffs2_find_gc_block
c00964d8 T jffs2_garbage_collect_pass
c00969bc t jffs2_garbage_collect_live
c0096db8 t jffs2_garbage_collect_pristine
c00971f8 t jffs2_garbage_collect_metadata
c00974f4 t jffs2_garbage_collect_dirent
c0097708 t jffs2_garbage_collect_deletion_dirent
c00977c0 t jffs2_garbage_collect_hole
c0097c58 t jffs2_garbage_collect_dnode
c0098054 T jffs2_readlink
c00980dc T jffs2_follow_link
c0098154 t jffs2_build_filesystem
c0098418 T jffs2_build_inode_pass1
c0098514 T jffs2_build_remove_unlinked_inode
c0098608 T jffs2_do_mount_fs
c009882c T jffs2_erase_block
c00989b4 T jffs2_erase_pending_blocks
c0098b60 t jffs2_erase_succeeded
c0098bb4 t jffs2_erase_failed
c0098c3c t jffs2_erase_callback
c0098ca8 t jffs2_free_all_node_refs
c0098da8 T jffs2_erase_pending_trigger
c0098db4 t jffs2_mark_erased_block
c0099268 T jffs2_garbage_collect_trigger
c00992b8 T jffs2_start_garbage_collect_thread
c009939c T jffs2_stop_garbage_collect_thread
c0099400 t jffs2_garbage_collect_thread
c0099594 t thread_should_wake
c00995ec T jffs2_statfs
c009965c T jffs2_clear_inode
c0099688 T jffs2_read_inode
c0099984 T jffs2_remount_fs
c0099a18 T jffs2_write_super
c0099a64 T jffs2_new_inode
c0099bf8 T jffs2_do_fill_super
c0099e30 T jffs2_flash_direct_writev
c0099f10 t jffs2_read_super
c0099fd4 T jffs2_put_super


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
