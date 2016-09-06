Return-Path: <yamada.masahiro@socionext.com>
Received: from conuserg-12.nifty.com (conuserg-12.nifty.com [210.131.2.79])
 (using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (112/168 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sT4SW6z1DzDrq2
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Sep 2016 21:41:47 +1000 (AEST)
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>,
 Jaroslav Kysela <perex@perex.cz>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
 Geoff Levand <geoff@infradead.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Mark Brown <broonie@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Johannes Berg <johannes@sipsolutions.net>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] ALSA: squash lines for simple wrapper functions
Date: Tue,  6 Sep 2016 20:41:19 +0900
Message-Id: <1473162079-25001-1-git-send-email-yamada.masahiro@socionext.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Remove unneeded variables and assignments.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 sound/aoa/fabrics/layout.c                  |  7 +------
 sound/pci/asihpi/hpifunc.c                  |  7 ++-----
 sound/pci/ctxfi/ctvmem.c                    |  6 +-----
 sound/pci/emu10k1/p16v.c                    | 16 ++++------------
 sound/pci/ice1712/ice1724.c                 |  4 +---
 sound/ppc/snd_ps3.c                         |  4 +---
 sound/soc/intel/baytrail/sst-baytrail-ipc.c | 12 +++---------
 7 files changed, 13 insertions(+), 43 deletions(-)

diff --git a/sound/aoa/fabrics/layout.c b/sound/aoa/fabrics/layout.c
index 8f71f7e..b6ba091 100644
--- a/sound/aoa/fabrics/layout.c
+++ b/sound/aoa/fabrics/layout.c
@@ -1161,12 +1161,7 @@ static struct soundbus_driver aoa_soundbus_driver = {
 
 static int __init aoa_fabric_layout_init(void)
 {
-	int err;
-
-	err = soundbus_register_driver(&aoa_soundbus_driver);
-	if (err)
-		return err;
-	return 0;
+	return soundbus_register_driver(&aoa_soundbus_driver);
 }
 
 static void __exit aoa_fabric_layout_exit(void)
diff --git a/sound/pci/asihpi/hpifunc.c b/sound/pci/asihpi/hpifunc.c
index 510e56c..f9b5764 100644
--- a/sound/pci/asihpi/hpifunc.c
+++ b/sound/pci/asihpi/hpifunc.c
@@ -2323,11 +2323,8 @@ u16 hpi_sample_clock_get_source_index(u32 h_control, u16 *pw_source_index)
 u16 hpi_sample_clock_query_local_rate(const u32 h_clock, const u32 index,
 	u32 *prate)
 {
-	u16 err;
-	err = hpi_control_query(h_clock, HPI_SAMPLECLOCK_LOCAL_SAMPLERATE,
-		index, 0, prate);
-
-	return err;
+	return hpi_control_query(h_clock, HPI_SAMPLECLOCK_LOCAL_SAMPLERATE,
+				 index, 0, prate);
 }
 
 u16 hpi_sample_clock_set_local_rate(u32 h_control, u32 sample_rate)
diff --git a/sound/pci/ctxfi/ctvmem.c b/sound/pci/ctxfi/ctvmem.c
index 419306e..520e19b 100644
--- a/sound/pci/ctxfi/ctvmem.c
+++ b/sound/pci/ctxfi/ctvmem.c
@@ -166,11 +166,7 @@ static void ct_vm_unmap(struct ct_vm *vm, struct ct_vm_block *block)
 static dma_addr_t
 ct_get_ptp_phys(struct ct_vm *vm, int index)
 {
-	dma_addr_t addr;
-
-	addr = (index >= CT_PTP_NUM) ? ~0UL : vm->ptp[index].addr;
-
-	return addr;
+	return (index >= CT_PTP_NUM) ? ~0UL : vm->ptp[index].addr;
 }
 
 int ct_vm_create(struct ct_vm **rvm, struct pci_dev *pci)
diff --git a/sound/pci/emu10k1/p16v.c b/sound/pci/emu10k1/p16v.c
index 3c60b43..87f6622 100644
--- a/sound/pci/emu10k1/p16v.c
+++ b/sound/pci/emu10k1/p16v.c
@@ -300,37 +300,29 @@ static int snd_p16v_pcm_open_capture(struct snd_pcm_substream *substream)
 static int snd_p16v_pcm_hw_params_playback(struct snd_pcm_substream *substream,
 				      struct snd_pcm_hw_params *hw_params)
 {
-	int result;
-	result = snd_pcm_lib_malloc_pages(substream,
+	return snd_pcm_lib_malloc_pages(substream,
 					params_buffer_bytes(hw_params));
-	return result;
 }
 
 /* hw_params callback */
 static int snd_p16v_pcm_hw_params_capture(struct snd_pcm_substream *substream,
 				      struct snd_pcm_hw_params *hw_params)
 {
-	int result;
-	result = snd_pcm_lib_malloc_pages(substream,
+	return snd_pcm_lib_malloc_pages(substream,
 					params_buffer_bytes(hw_params));
-	return result;
 }
 
 
 /* hw_free callback */
 static int snd_p16v_pcm_hw_free_playback(struct snd_pcm_substream *substream)
 {
-	int result;
-	result = snd_pcm_lib_free_pages(substream);
-	return result;
+	return snd_pcm_lib_free_pages(substream);
 }
 
 /* hw_free callback */
 static int snd_p16v_pcm_hw_free_capture(struct snd_pcm_substream *substream)
 {
-	int result;
-	result = snd_pcm_lib_free_pages(substream);
-	return result;
+	return snd_pcm_lib_free_pages(substream);
 }
 
 
diff --git a/sound/pci/ice1712/ice1724.c b/sound/pci/ice1712/ice1724.c
index 0b22c00..4731e9c 100644
--- a/sound/pci/ice1712/ice1724.c
+++ b/sound/pci/ice1712/ice1724.c
@@ -620,9 +620,7 @@ static const unsigned int stdclock_rate_list[16] = {
 
 static unsigned int stdclock_get_rate(struct snd_ice1712 *ice)
 {
-	unsigned int rate;
-	rate = stdclock_rate_list[inb(ICEMT1724(ice, RATE)) & 15];
-	return rate;
+	return stdclock_rate_list[inb(ICEMT1724(ice, RATE)) & 15];
 }
 
 static void stdclock_set_rate(struct snd_ice1712 *ice, unsigned int rate)
diff --git a/sound/ppc/snd_ps3.c b/sound/ppc/snd_ps3.c
index 3682425..b84d7d3 100644
--- a/sound/ppc/snd_ps3.c
+++ b/sound/ppc/snd_ps3.c
@@ -564,9 +564,7 @@ static int snd_ps3_pcm_hw_params(struct snd_pcm_substream *substream,
 
 static int snd_ps3_pcm_hw_free(struct snd_pcm_substream *substream)
 {
-	int ret;
-	ret = snd_pcm_lib_free_pages(substream);
-	return ret;
+	return snd_pcm_lib_free_pages(substream);
 };
 
 static int snd_ps3_delay_to_bytes(struct snd_pcm_substream *substream,
diff --git a/sound/soc/intel/baytrail/sst-baytrail-ipc.c b/sound/soc/intel/baytrail/sst-baytrail-ipc.c
index 5bbaa66..c8455b4 100644
--- a/sound/soc/intel/baytrail/sst-baytrail-ipc.c
+++ b/sound/soc/intel/baytrail/sst-baytrail-ipc.c
@@ -184,15 +184,9 @@ struct sst_byt {
 
 static inline u64 sst_byt_header(int msg_id, int data, bool large, int str_id)
 {
-	u64 header;
-
-	header = IPC_HEADER_MSG_ID(msg_id) |
-		 IPC_HEADER_STR_ID(str_id) |
-		 IPC_HEADER_LARGE(large) |
-		 IPC_HEADER_DATA(data) |
-		 SST_BYT_IPCX_BUSY;
-
-	return header;
+	return IPC_HEADER_MSG_ID(msg_id) | IPC_HEADER_STR_ID(str_id) |
+	       IPC_HEADER_LARGE(large) | IPC_HEADER_DATA(data) |
+	       SST_BYT_IPCX_BUSY;
 }
 
 static inline u16 sst_byt_header_msg_id(u64 header)
-- 
1.9.1
