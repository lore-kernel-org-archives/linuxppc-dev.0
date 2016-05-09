Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-ig0-x242.google.com (mail-ig0-x242.google.com
 [IPv6:2607:f8b0:4001:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r3G2N3DDGzDq64
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 May 2016 18:36:43 +1000 (AEST)
Received: by mail-ig0-x242.google.com with SMTP id rc4so10840883igc.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 May 2016 01:36:43 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1462782250-6231-1-git-send-email-geert@linux-m68k.org>
References: <1462782250-6231-1-git-send-email-geert@linux-m68k.org>
Date: Mon, 9 May 2016 10:36:41 +0200
Message-ID: <CAMuHMdWAiX03Oejt6ovLaHc6sNwX+Y5-nAASDRJEfmeMAq_4Sg@mail.gmail.com>
Subject: Re: Build regressions/improvements in v4.6-rc7
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Linux-sh list <linux-sh@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, May 9, 2016 at 10:24 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> JFYI, when comparing v4.6-rc7[1] to v4.6-rc6[3], the summaries are:
>   - build errors: +188/-7

For a quiet -rc7, the results are devastating:

  + /home/kisskb/slave/src/arch/sh/kernel/setup.c: error: implicit
declaration of function 'early_init_dt_scan'
[-Werror=implicit-function-declaration]:  => 256:2

sh-randconfig

  + /home/kisskb/slave/src/drivers/net/ethernet/3com/typhoon.c: error:
case label does not reduce to an integer constant:  => 1007:2, 1016:2,
1010:2, 1013:2, 1019:2
  + /home/kisskb/slave/src/drivers/staging/rtl8192e/rtl8192e/rtl_core.c:
error: (near initialization for 'def_qos_parameters.cw_max[0]'):  =>
372:2
  + /home/kisskb/slave/src/drivers/staging/rtl8192e/rtl8192e/rtl_core.c:
error: (near initialization for 'def_qos_parameters.cw_max[1]'):  =>
372:2
  + /home/kisskb/slave/src/drivers/staging/rtl8192e/rtl8192e/rtl_core.c:
error: (near initialization for 'def_qos_parameters.cw_max[2]'):  =>
372:2
  + /home/kisskb/slave/src/drivers/staging/rtl8192e/rtl8192e/rtl_core.c:
error: (near initialization for 'def_qos_parameters.cw_max[3]'):  =>
372:2
  + /home/kisskb/slave/src/drivers/staging/rtl8192e/rtl8192e/rtl_core.c:
error: (near initialization for 'def_qos_parameters.cw_min[0]'):  =>
371:2
  + /home/kisskb/slave/src/drivers/staging/rtl8192e/rtl8192e/rtl_core.c:
error: (near initialization for 'def_qos_parameters.cw_min[1]'):  =>
371:2
  + /home/kisskb/slave/src/drivers/staging/rtl8192e/rtl8192e/rtl_core.c:
error: (near initialization for 'def_qos_parameters.cw_min[2]'):  =>
371:2
  + /home/kisskb/slave/src/drivers/staging/rtl8192e/rtl8192e/rtl_core.c:
error: (near initialization for 'def_qos_parameters.cw_min[3]'):  =>
371:2
  + /home/kisskb/slave/src/drivers/staging/rtl8192e/rtl8192e/rtl_core.c:
error: initializer element is not constant:  => 371:2, 372:2
  + /home/kisskb/slave/src/drivers/staging/rtl8192u/r8192U_core.c:
error: (near initialization for 'def_qos_parameters.cw_max[0]'):  =>
1870:2
  + /home/kisskb/slave/src/drivers/staging/rtl8192u/r8192U_core.c:
error: (near initialization for 'def_qos_parameters.cw_max[1]'):  =>
1870:2
  + /home/kisskb/slave/src/drivers/staging/rtl8192u/r8192U_core.c:
error: (near initialization for 'def_qos_parameters.cw_max[2]'):  =>
1870:2
  + /home/kisskb/slave/src/drivers/staging/rtl8192u/r8192U_core.c:
error: (near initialization for 'def_qos_parameters.cw_max[3]'):  =>
1870:2
  + /home/kisskb/slave/src/drivers/staging/rtl8192u/r8192U_core.c:
error: (near initialization for 'def_qos_parameters.cw_min[0]'):  =>
1869:2
  + /home/kisskb/slave/src/drivers/staging/rtl8192u/r8192U_core.c:
error: (near initialization for 'def_qos_parameters.cw_min[1]'):  =>
1869:2
  + /home/kisskb/slave/src/drivers/staging/rtl8192u/r8192U_core.c:
error: (near initialization for 'def_qos_parameters.cw_min[2]'):  =>
1869:2
  + /home/kisskb/slave/src/drivers/staging/rtl8192u/r8192U_core.c:
error: (near initialization for 'def_qos_parameters.cw_min[3]'):  =>
1869:2
  + /home/kisskb/slave/src/drivers/staging/rtl8192u/r8192U_core.c:
error: initializer element is not constant:  => 1869:2, 1870:2
  + /home/kisskb/slave/src/drivers/usb/chipidea/udc.c: error: (near
initialization for 'ctrl_endpt_in_desc.wMaxPacketSize'):  => 50:2
  + /home/kisskb/slave/src/drivers/usb/chipidea/udc.c: error: (near
initialization for 'ctrl_endpt_out_desc.wMaxPacketSize'):  => 40:2
  + /home/kisskb/slave/src/drivers/usb/chipidea/udc.c: error:
initializer element is not constant:  => 50:2, 40:2
  + /home/kisskb/slave/src/drivers/usb/image/mdc800.c: error: (near
initialization for 'mdc800_ed[0].wMaxPacketSize'):  => 191:3
  + /home/kisskb/slave/src/drivers/usb/image/mdc800.c: error: (near
initialization for 'mdc800_ed[1].wMaxPacketSize'):  => 201:3
  + /home/kisskb/slave/src/drivers/usb/image/mdc800.c: error: (near
initialization for 'mdc800_ed[2].wMaxPacketSize'):  => 211:3
  + /home/kisskb/slave/src/drivers/usb/image/mdc800.c: error: (near
initialization for 'mdc800_ed[3].wMaxPacketSize'):  => 221:3
  + /home/kisskb/slave/src/drivers/usb/image/mdc800.c: error:
initializer element is not constant:  => 191:3, 211:3, 221:3, 201:3
  + /home/kisskb/slave/src/fs/cifs/smb1ops.c: error: (near
initialization for 'smb1_values.lock_cmd'):  => 1110:2
  + /home/kisskb/slave/src/fs/cifs/smb1ops.c: error: initializer
element is not constant  LD      security/built-in.o:  => 1110:2
  + /home/kisskb/slave/src/fs/cifs/smb1ops.c: error: initializer
element is not constant:  => 1110:2
  + /home/kisskb/slave/src/fs/hpfs/hpfs.h: error: enumerator value for
'FNODE_anode' is not an integer constant:  => 435:7
  + /home/kisskb/slave/src/fs/hpfs/hpfs.h: error: enumerator value for
'FNODE_dir' is not an integer constant:  => 435:37
  + /home/kisskb/slave/src/fs/ntfs/dir.c: error: (near initialization
for 'I30[0]'):  => 36:1
  + /home/kisskb/slave/src/fs/ntfs/dir.c: error: (near initialization
for 'I30[1]'):  => 36:1
  + /home/kisskb/slave/src/fs/ntfs/dir.c: error: (near initialization
for 'I30[2]'):  => 37:3
  + /home/kisskb/slave/src/fs/ntfs/dir.c: error: (near initialization
for 'I30[3]'):  => 37:3
  + /home/kisskb/slave/src/fs/ntfs/dir.c: error: initializer element
is not constant:  => 36:1, 37:3
  + /home/kisskb/slave/src/fs/ntfs/layout.h: error: enumerator value
for 'ATTR_COMPRESSION_MASK' is not an integer constant:  => 607:2
  + /home/kisskb/slave/src/fs/ntfs/layout.h: error: enumerator value
for 'ATTR_IS_COMPRESSED' is not an integer constant:  => 606:2
  + /home/kisskb/slave/src/fs/ntfs/layout.h: error: enumerator value
for 'ATTR_IS_ENCRYPTED' is not an integer constant:  => 610:2
  + /home/kisskb/slave/src/fs/ntfs/layout.h: error: enumerator value
for 'ATTR_IS_SPARSE' is not an integer constant:  => 611:2
  + /home/kisskb/slave/src/fs/ntfs/layout.h: error: enumerator value
for 'INDEX_ENTRY_END' is not an integer constant:  => 2184:2
  + /home/kisskb/slave/src/fs/ntfs/layout.h: error: enumerator value
for 'INDEX_ENTRY_NODE' is not an integer constant:  => 2181:2
  + /home/kisskb/slave/src/fs/ntfs/layout.h: error: enumerator value
for 'INDEX_ENTRY_SPACE_FILLER' is not an integer constant:  => 2188:2
  + /home/kisskb/slave/src/fs/ntfs/layout.h: error: enumerator value
for 'MFT_RECORD_IN_USE' is not an integer constant:  => 250:2
  + /home/kisskb/slave/src/fs/ntfs/layout.h: error: enumerator value
for 'MFT_RECORD_IS_DIRECTORY' is not an integer constant:  => 251:2
  + /home/kisskb/slave/src/fs/ntfs/layout.h: error: enumerator value
for 'SE_DACL_AUTO_INHERITED' is not an integer constant:  => 1708:2
  + /home/kisskb/slave/src/fs/ntfs/layout.h: error: enumerator value
for 'SE_DACL_AUTO_INHERIT_REQ' is not an integer constant:  => 1706:2
  + /home/kisskb/slave/src/fs/ntfs/layout.h: error: enumerator value
for 'SE_DACL_DEFAULTED' is not an integer constant:  => 1701:2
  + /home/kisskb/slave/src/fs/ntfs/layout.h: error: enumerator value
for 'SE_DACL_PRESENT' is not an integer constant:  => 1700:2
  + /home/kisskb/slave/src/fs/ntfs/layout.h: error: enumerator value
for 'SE_DACL_PRESENT' is not an integer constantmake[4]: :  => 1700:2
  + /home/kisskb/slave/src/fs/ntfs/layout.h: error: enumerator value
for 'SE_DACL_PROTECTED' is not an integer constant:  => 1711:2
  + /home/kisskb/slave/src/fs/ntfs/layout.h: error: enumerator value
for 'SE_GROUP_DEFAULTED' is not an integer constant:  => 1699:2
  + /home/kisskb/slave/src/fs/ntfs/layout.h: error: enumerator value
for 'SE_OWNER_DEFAULTED' is not an integer constant:  => 1698:2
  + /home/kisskb/slave/src/fs/ntfs/layout.h: error: enumerator value
for 'SE_RM_CONTROL_VALID' is not an integer constant:  => 1713:2
  + /home/kisskb/slave/src/fs/ntfs/layout.h: error: enumerator value
for 'SE_SACL_AUTO_INHERITED' is not an integer constant:  => 1709:2
  + /home/kisskb/slave/src/fs/ntfs/layout.h: error: enumerator value
for 'SE_SACL_AUTO_INHERIT_REQ' is not an integer constant:  => 1707:2
  + /home/kisskb/slave/src/fs/ntfs/layout.h: error: enumerator value
for 'SE_SACL_DEFAULTED' is not an integer constant:  => 1704:2
  + /home/kisskb/slave/src/fs/ntfs/layout.h: error: enumerator value
for 'SE_SACL_PRESENT' is not an integer constant:  => 1703:2
  + /home/kisskb/slave/src/fs/ntfs/layout.h: error: enumerator value
for 'SE_SACL_PROTECTED' is not an integer constant:  => 1712:2
  + /home/kisskb/slave/src/fs/ntfs/layout.h: error: enumerator value
for 'SE_SELF_RELATIVE' is not an integer constant:  => 1715:1
  + /home/kisskb/slave/src/fs/ntfs/layout.h: error: enumerator value
for 'VOLUME_CHKDSK_UNDERWAY' is not an integer constant:  => 1910:2
  + /home/kisskb/slave/src/fs/ntfs/layout.h: error: enumerator value
for 'VOLUME_DELETE_USN_UNDERWAY' is not an integer constant:  =>
1907:2
  + /home/kisskb/slave/src/fs/ntfs/layout.h: error: enumerator value
for 'VOLUME_FLAGS_MASK' is not an integer constant:  => 1913:2
  + /home/kisskb/slave/src/fs/ntfs/layout.h: error: enumerator value
for 'VOLUME_IS_DIRTY' is not an integer constant:  => 1902:2
  + /home/kisskb/slave/src/fs/ntfs/layout.h: error: enumerator value
for 'VOLUME_MODIFIED_BY_CHKDSK' is not an integer constant:  => 1911:2
  + /home/kisskb/slave/src/fs/ntfs/layout.h: error: enumerator value
for 'VOLUME_MOUNTED_ON_NT4' is not an integer constant:  => 1905:2
  + /home/kisskb/slave/src/fs/ntfs/layout.h: error: enumerator value
for 'VOLUME_MUST_MOUNT_RO_MASK' is not an integer constant:  => 1916:2
  + /home/kisskb/slave/src/fs/ntfs/layout.h: error: enumerator value
for 'VOLUME_REPAIR_OBJECT_ID' is not an integer constant:  => 1908:2
  + /home/kisskb/slave/src/fs/ntfs/layout.h: error: enumerator value
for 'VOLUME_RESIZE_LOG_FILE' is not an integer constant:  => 1903:2
  + /home/kisskb/slave/src/fs/ntfs/layout.h: error: enumerator value
for 'VOLUME_UPGRADE_ON_MOUNT' is not an integer constant:  => 1904:2
  + /home/kisskb/slave/src/fs/ocfs2/xattr.c: error: (near
initialization for 'def_xv.xv.xr_list.l_count'):  => 97:2
  + /home/kisskb/slave/src/fs/ocfs2/xattr.c: error: initializer
element is not constant:  => 97:2
  + /home/kisskb/slave/src/lib/test_bpf.c: error: (near initialization
for 'tests[206].test[0].result'):  => 4098:3
  + /home/kisskb/slave/src/lib/test_bpf.c: error: initializer element
is not constant:  => 4098:3
  + /home/kisskb/slave/src/lib/vsprintf.c: error: (near initialization
for 'decpair[0]'):  => 159:2

    [...]

  + /home/kisskb/slave/src/lib/vsprintf.c: error: (near initialization
for 'decpair[9]'):  => 159:2
  + /home/kisskb/slave/src/lib/vsprintf.c: error: initializer element
is not constant  CC      drivers/clk/clk-fixed-rate.o:  => 164:2
  + /home/kisskb/slave/src/lib/vsprintf.c: error: initializer element
is not constant:  => 160:2, 168:2, 162:2, 166:2, 167:2, 165:2, 164:2,
161:2, 163:2, 159:2
  + /home/kisskb/slave/src/net/mac80211/main.c: error: (near
initialization for 'mac80211_ht_capa_mod_mask.cap_info'):  => 452:2
  + /home/kisskb/slave/src/net/mac80211/main.c: error: (near
initialization for 'mac80211_vht_capa_mod_mask.supp_mcs.rx_mcs_map'):
=> 480:3
  + /home/kisskb/slave/src/net/mac80211/main.c: error: (near
initialization for 'mac80211_vht_capa_mod_mask.supp_mcs.tx_mcs_map'):
=> 481:3
  + /home/kisskb/slave/src/net/mac80211/main.c: error: initializer
element is not constant:  => 480:3, 481:3, 452:2
  + /home/kisskb/slave/src/net/wireless/util.c: error: case label does
not reduce to an integer constant:  => 459:2, 453:2, 493:2, 476:2

Various powerpc configs

  + error: page_ext.c: undefined reference to `mm_drop_all_locks':  =>
.text+0x1ecb8)
  + error: page_ext.c: undefined reference to `mm_take_all_locks':  =>
.text+0x1ec30)
  + error: zynq-fpga.c: undefined reference to `can_do_mlock':  =>
.text+0x384e1c)
  + error: zynq-fpga.c: undefined reference to
`get_user_pages_remote':  => .text+0x385ed8)

arm-randconfig

> [1] http://kisskb.ellerman.id.au/kisskb/head/10306/ (all 262 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/10264/ (all 262 configs)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
