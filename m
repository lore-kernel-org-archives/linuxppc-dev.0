Return-Path: <owner-linuxppc-dev@lists.linuxppc.org>
Message-Id: <200201072201.RAA05808@missioncriticallinux.com>
From: mod+linuxppc-dev@MissionCriticalLinux.com
To: linuxppc-dev@lists.linuxppc.org
Subject: Link-time failures from "simple" CFLAGS changes
Date: Mon, 07 Jan 2002 17:01:51 -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


When I change -O2 to -O0 in my CFLAGS definition in Makefile thus:


  CFLAGS := -g $(CPPFLAGS) -Wall -Wstrict-prototypes -Wno-trigraphs -O0 \
                               -fno-strict-aliasing -fno-common


  CFLAGS := -g $(CPPFLAGS) -Wall -Wstrict-prototypes -Wno-trigraphs -O2 \
                               -fno-strict-aliasing -fno-common


...I am astounded to see thousands of unresolved references
at kernel link time.  WTF?  Any ideas?  These are the
sorts of symbols that come up undefined:


 after __bad_udelay before between clear_user copy_from_user copy_siginfo
 copy_to_user dcacheFlushSingle dcacheInvalidateSingle dev_load down
 down_interruptible down_trylock DQUOT_ALLOC_BLOCK DQUOT_FREE_BLOCK
 DQUOT_PREALLOC_BLOCK eieio empty_stack fib_find_info fn_flush_list
 fn_key_eq fn_key_leq frag_alloc_queue frag_free_queue frag_kfree_skb
 free_pgd_fast free_pgd_slow get_native_tbl get_order get_pgd_fast
 get_rtcl get_tbl get_tbu __get_user_bad htonl htons in_8 inet_getid
 inet_putpeer in_le16 in_le32 ipc_buildid ipc_checkid ipc_get ipc_lock
 ipc_lockall ipc_unlock ipc_unlockall ld_le32 maybe_unmark_and_push
 ntohl ntohs out_8 out_be32 out_le16 out_le32 pcibios_make_OF_bus_map
 pcibios_set_master phys_to_virt pmd_populate pop_stack prefetch
 prefetchw pte_free_slow __put_user_bad rotate_left rtnetlink_rcv_skb SBI
 __skb_cb_too_small_for_tcp sockfd_put socki_lookup strncpy_from_user
 strnlen_user tb_ticks_since tcpdiag_rcv_skb tcp_need_reset
 tcp_paws_discard tcp_replace_ts_recent tcp_store_ts_recent __udelay
 unix_get_socket unix_release_addr up __USE_RTC verify_area virt_to_bus
 virt_to_phys __xchg_called_with_bad_pointer xprt_move_iov


This isn't a showstopper problem for me but I was so surprised to see
it that I'm curious about its cause, so thanks for any enlightenment.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
