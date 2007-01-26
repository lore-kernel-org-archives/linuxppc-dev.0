Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 43F43DE003
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Jan 2007 15:13:51 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 1/9] ps3: AV Settings Driver
Date: Fri, 26 Jan 2007 05:13:23 +0100
References: <Pine.LNX.4.62.0701251825390.14799@pademelon.sonytel.be>
	<Pine.LNX.4.62.0701251846460.24610@pademelon.sonytel.be>
In-Reply-To: <Pine.LNX.4.62.0701251846460.24610@pademelon.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200701260513.24010.arnd@arndb.de>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	Paul Mackerras <paulus@samba.org>, James Simmons <jsimmons@infradead.org>,
	Linux Frame Buffer Device Development
	<linux-fbdev-devel@lists.sourceforge.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 25 January 2007 18:48, Geert Uytterhoeven wrote:
> +
> +#ifdef PS3AV_DEBUG
> +#define DPRINTK(fmt, args...) \
> +	do { printk("ps3av " fmt, ## args); } while (0)
> +#else
> +#define DPRINTK(fmt, args...) do { } while (0)
> +#endif

You should probably use the provided pr_debug or (better) dev_dbg
macros to do that now.

> +} video_mode_table[] = {
> +	{     0, }, /* auto */
> +	{YUV444, XRGB, PS3AV_CMD_VIDEO_VID_480I,       A_N,  720,  480, 1, 60},
> +	{YUV444, XRGB, PS3AV_CMD_VIDEO_VID_480P,       A_N,  720,  480, 0, 60},
> +	{YUV444, XRGB, PS3AV_CMD_VIDEO_VID_720P_60HZ,  A_N, 1280,  720, 0, 60},
> +	{YUV444, XRGB, PS3AV_CMD_VIDEO_VID_1080I_60HZ, A_W, 1920, 1080, 1, 60},
> +	{YUV444, XRGB, PS3AV_CMD_VIDEO_VID_1080P_60HZ, A_W, 1920, 1080, 0, 60},
> +	{YUV444, XRGB, PS3AV_CMD_VIDEO_VID_576I,       A_N,  720,  576, 1, 50},
> +	{YUV444, XRGB, PS3AV_CMD_VIDEO_VID_576P,       A_N,  720,  576, 0, 50},
> +	{YUV444, XRGB, PS3AV_CMD_VIDEO_VID_720P_50HZ,  A_N, 1280,  720, 0, 50},
> +	{YUV444, XRGB, PS3AV_CMD_VIDEO_VID_1080I_50HZ, A_W, 1920, 1080, 1, 50},
> +	{YUV444, XRGB, PS3AV_CMD_VIDEO_VID_1080P_50HZ, A_W, 1920, 1080, 0, 50},
> +	{  RGB8, XRGB, PS3AV_CMD_VIDEO_VID_WXGA,       A_W, 1280,  768, 0, 60},
> +	{  RGB8, XRGB, PS3AV_CMD_VIDEO_VID_SXGA,       A_N, 1280, 1024, 0, 60},
> +	{  RGB8, XRGB, PS3AV_CMD_VIDEO_VID_WUXGA,      A_W, 1920, 1200, 0, 60},
> +};

Is there a fundamental reason why 1280x768 is not supported as YUV? That is
the resolution that my TV set at home has natively, and I'd like to use it.

> +	if (down_interruptible(&ps3av.sem)) {
> +		printk(KERN_ERR "%s:sem failed cid:%x \n", __FUNCTION__, cid);
> +		return -ERESTARTSYS;
> +	}

This should not normally be considered an error, since a user can
trigger it easily.

> +
> +	table = ps3av_search_cmd_table(cid, PS3AV_CID_MASK);
> +	if (table == NULL) {
> +		printk(KERN_ERR "%s: invalid_cid:%x\n", __FUNCTION__, cid);
> +		res = -EINVAL;
> +		goto err;
> +	}
> +
> +	if (send_len < PS3AV_HDR_SIZE) {
> +		printk(KERN_ERR "%s: invalid send_len:%d\n", __FUNCTION__,
> +		       send_len);
> +		goto err;
> +	}
> +

What's the point in these checks? All callers of your function seem to be
from kernel space, so it can't really trigger here unless there is a bug
in the model.
I guess it could either be a BUG_ON() if you want to verify the validity
of your code, or you should leave out ps3av_search_cmd_table() entirely.

> +	msleep(100);
> +
> +	/* video mute on */
> +	for (i = 0; i < num_of_av_port; i++) {
> +		res = ps3av_cmd_av_video_disable_sig(ps3av.av_port[i]);
> +		if (res < 0)
> +			return -1;
> +		if (i < num_of_hdmi_port) {
> +			res = ps3av_cmd_av_tv_mute(ps3av.av_port[i],
> +						   PS3AV_CMD_MUTE_OFF);
> +			if (res < 0)
> +				return -1;
> +		}
> +	}
> +	msleep(300);

400 ms total wait time is very noticeable to the user. Is it possible to
reduce that time?

> +
> +	msleep(1500);
> +	/* av video mute */
> +	ps3av_set_av_video_mute(PS3AV_CMD_MUTE_OFF);

This is an even longer time to wait for. What about this one?

> +#ifdef PS3AV_DEBUG
> +	ps3av_cmd_av_hw_conf_dump(&ps3av->av_hw_conf);
> +#endif

It would be better to avoid this ifdef by defining an empty function
in the header file if PS3AV_DEBUG is not set.

> +	/* set videomode */
> +	old_id = atomic_read(&ps3av.ps3av_mode);
> +	atomic_set(&ps3av.ps3av_mode, id);
> +	if (ps3av_set_videomode(id))
> +		atomic_set(&ps3av.ps3av_mode, old_id);

This is not really atomic at all. If you want the update to be
atomic here, you should probably try to use atomic_cmpxchg().
Otherwise a regular int inside of a mutex might be more appropriate.

> +EXPORT_SYMBOL(ps3av_set_video_mode);

Is it intentionally EXPORT_SYMBOL instead of EXPORT_SYMBOL_GPL?
Normally, we try to make all new symbols _GPL, though it is obviously
without your own judgment to decide on which you use.

> +
> +int ps3av_set_mode(u32 id, int boot)
> +{
> +	int res;
> +
> +	res = ps3av_set_video_mode(id, boot);
> +	if (res)
> +		return -1;
> +
> +	res = ps3av_set_audio_mode(PS3AV_CMD_AUDIO_NUM_OF_CH_2,
> +				   PS3AV_CMD_AUDIO_FS_48K,
> +				   PS3AV_CMD_AUDIO_WORD_BITS_16,
> +				   PS3AV_CMD_AUDIO_FORMAT_PCM,
> +				   PS3AV_CMD_AUDIO_SOURCE_SERIAL);
> +	if (res)
> +		return -1;
> +
> +	return 0;
> +}

Common convention would be to use -ESOMETHING instead of -1 as the return
code.

> +static u32 ps3av_cs_video2av_bitlen(int cs)
> +{
> +	u32 res = 0;
> +
> +	switch (cs) {
> +	case PS3AV_CMD_VIDEO_CS_RGB_8:
> +	case PS3AV_CMD_VIDEO_CS_YUV444_8:
> +	case PS3AV_CMD_VIDEO_CS_YUV422_8:
> +	case PS3AV_CMD_VIDEO_CS_XVYCC_8:
> +		res = PS3AV_CMD_AV_CS_8;
> +		break;
> +	case PS3AV_CMD_VIDEO_CS_RGB_10:
> +	case PS3AV_CMD_VIDEO_CS_YUV444_10:
> +	case PS3AV_CMD_VIDEO_CS_YUV422_10:
> +	case PS3AV_CMD_VIDEO_CS_XVYCC_10:
> +		res = PS3AV_CMD_AV_CS_10;
> +		break;
> +	case PS3AV_CMD_VIDEO_CS_RGB_12:
> +	case PS3AV_CMD_VIDEO_CS_YUV444_12:
> +	case PS3AV_CMD_VIDEO_CS_YUV422_12:
> +	case PS3AV_CMD_VIDEO_CS_XVYCC_12:
> +		res = PS3AV_CMD_AV_CS_12;
> +		break;
> +	default:
> +		res = PS3AV_CMD_AV_CS_8;
> +		break;
> +	}
> +	return res;
> +}
> +
> +static u32 ps3av_vid_video2av(int vid)
> +{
> +	u32 res = 0;
> +
> +	switch (vid) {
> +	case PS3AV_CMD_VIDEO_VID_480I:
> +		res = PS3AV_CMD_AV_VID_480I;
> +		break;
> +	case PS3AV_CMD_VIDEO_VID_480P:
> +		res = PS3AV_CMD_AV_VID_480P;
> +		break;
> +	case PS3AV_CMD_VIDEO_VID_576I:
> +		res = PS3AV_CMD_AV_VID_576I;
> +		break;
> +	case PS3AV_CMD_VIDEO_VID_576P:
> +		res = PS3AV_CMD_AV_VID_576P;
> +		break;
> +	case PS3AV_CMD_VIDEO_VID_1080I_60HZ:
> +		res = PS3AV_CMD_AV_VID_1080I_60HZ;
> +		break;
> +	case PS3AV_CMD_VIDEO_VID_720P_60HZ:
> +		res = PS3AV_CMD_AV_VID_720P_60HZ;
> +		break;
> +	case PS3AV_CMD_VIDEO_VID_1080P_60HZ:
> +		res = PS3AV_CMD_AV_VID_1080P_60HZ;
> +		break;
> +	case PS3AV_CMD_VIDEO_VID_1080I_50HZ:
> +		res = PS3AV_CMD_AV_VID_1080I_50HZ;
> +		break;
> +	case PS3AV_CMD_VIDEO_VID_720P_50HZ:
> +		res = PS3AV_CMD_AV_VID_720P_50HZ;
> +		break;
> +	case PS3AV_CMD_VIDEO_VID_1080P_50HZ:
> +		res = PS3AV_CMD_AV_VID_1080P_50HZ;
> +		break;
> +	case PS3AV_CMD_VIDEO_VID_WXGA:
> +		res = PS3AV_CMD_AV_VID_WXGA;
> +		break;
> +	case PS3AV_CMD_VIDEO_VID_SXGA:
> +		res = PS3AV_CMD_AV_VID_SXGA;
> +		break;
> +	case PS3AV_CMD_VIDEO_VID_WUXGA:
> +		res = PS3AV_CMD_AV_VID_WUXGA;
> +		break;
> +	default:
> +		res = PS3AV_CMD_AV_VID_480P;
> +		break;
> +	}
> +	return res;
> +}

Maybe replace these with lookup tables for smaller code size?

> +static u8 ps3av_cnv_mclk(u32 fs)
> +{
> +	u8 mclk;
> +
> +	switch (fs) {
> +	case PS3AV_CMD_AUDIO_FS_44K:
> +		mclk = PS3AV_CMD_AV_MCLK_512;
> +		break;
> +	case PS3AV_CMD_AUDIO_FS_48K:
> +		mclk = PS3AV_CMD_AV_MCLK_512;
> +		break;
> +	case PS3AV_CMD_AUDIO_FS_88K:
> +		mclk = PS3AV_CMD_AV_MCLK_256;
> +		break;
> +	case PS3AV_CMD_AUDIO_FS_96K:
> +		mclk = PS3AV_CMD_AV_MCLK_256;
> +		break;
> +	case PS3AV_CMD_AUDIO_FS_176K:
> +		mclk = PS3AV_CMD_AV_MCLK_128;
> +		break;
> +	case PS3AV_CMD_AUDIO_FS_192K:
> +		mclk = PS3AV_CMD_AV_MCLK_128;
> +		break;
> +	default:
> +		printk(KERN_ERR "%s failed, fs:%x\n", __FUNCTION__, fs);
> +		mclk = 0;
> +		break;
> +	}
> +	return mclk;
> +}

Same here.

> +
> +static const u32 ps3av_ns_table[][5] = {
> +	/*   D1,    D2,    D3,    D4,    D5 */
> +	{  6272,  6272, 17836, 17836,  8918 },	/*  44K */
> +	{  6144,  6144, 11648, 11648,  5824 },	/*  48K */
> +	{ 12544, 12544, 35672, 35672, 17836 },	/*  88K */
> +	{ 12288, 12288, 23296, 23296, 11648 },	/*  96K */
> +	{ 25088, 25088, 71344, 71344, 35672 },	/* 176K */
> +	{ 24576, 24576, 46592, 46592, 23296 },	/* 192K */
> +};

When writing such a table, it's often clearer to use named indexes
instead of the comments, like

static const u32 ps3av_ns_table[][5] = {
				 /*   D1,    D2,    D3,    D4,    D5 */
	[PS3AV_CMD_AUDIO_FS_44K]  {  6272,  6272, 17836, 17836,  8918 },
	[PS3AV_CMD_AUDIO_FS_48K]  {  6144,  6144, 11648, 11648,  5824 },
	[PS3AV_CMD_AUDIO_FS_88K]  { 12544, 12544, 35672, 35672, 17836 },
	[PS3AV_CMD_AUDIO_FS_96K]  { 12288, 12288, 23296, 23296, 11648 },
	[PS3AV_CMD_AUDIO_FS_176K] { 25088, 25088, 71344, 71344, 35672 },
	[PS3AV_CMD_AUDIO_FS_192K] { 24576, 24576, 46592, 46592, 23296 },
};

> +/* event_bit */
> +#define PS3AV_CMD_EVENT_BIT_UNPLUGGED			(1 << 0)
> +#define PS3AV_CMD_EVENT_BIT_PLUGGED			(1 << 1)
> +#define PS3AV_CMD_EVENT_BIT_HDCP_DONE			(1 << 2)
> +#define PS3AV_CMD_EVENT_BIT_HDCP_FAIL			(1 << 3)
> +#define PS3AV_CMD_EVENT_BIT_HDCP_REAUTH			(1 << 4)
> +#define PS3AV_CMD_EVENT_BIT_HDCP_TOPOLOGY		(1 << 5)

My personal taste is to write these as 

#define PS3AV_CMD_EVENT_BIT_UNPLUGGED			0x0001
#define PS3AV_CMD_EVENT_BIT_PLUGGED			0x0002
#define PS3AV_CMD_EVENT_BIT_HDCP_DONE			0x0004
#define PS3AV_CMD_EVENT_BIT_HDCP_FAIL			0x0008
#define PS3AV_CMD_EVENT_BIT_HDCP_REAUTH			0x0010
#define PS3AV_CMD_EVENT_BIT_HDCP_TOPOLOGY		0x0020

but just do whichever you prefer here.

> +/* for video module */
> +/* video_head */
> +#define PS3AV_CMD_VIDEO_HEAD_A				0x0000
> +#define PS3AV_CMD_VIDEO_HEAD_B				0x0001
> +/* video_cs_out video_cs_in */
> +#define PS3AV_CMD_VIDEO_CS_NONE				0x0000
> +#define PS3AV_CMD_VIDEO_CS_RGB_8			0x0001
> +#define PS3AV_CMD_VIDEO_CS_YUV444_8			0x0002
> +#define PS3AV_CMD_VIDEO_CS_YUV422_8			0x0003
> +#define PS3AV_CMD_VIDEO_CS_XVYCC_8			0x0004
> +#define PS3AV_CMD_VIDEO_CS_RGB_10			0x0005
> +#define PS3AV_CMD_VIDEO_CS_YUV444_10			0x0006
> +#define PS3AV_CMD_VIDEO_CS_YUV422_10			0x0007
> +#define PS3AV_CMD_VIDEO_CS_XVYCC_10			0x0008
> +#define PS3AV_CMD_VIDEO_CS_RGB_12			0x0009
> +#define PS3AV_CMD_VIDEO_CS_YUV444_12			0x000a
> +#define PS3AV_CMD_VIDEO_CS_YUV422_12			0x000b
> +#define PS3AV_CMD_VIDEO_CS_XVYCC_12			0x000c
> +/* video_vid */
> +#define PS3AV_CMD_VIDEO_VID_NONE			0x0000
> +#define PS3AV_CMD_VIDEO_VID_480I			0x0001
> +#define PS3AV_CMD_VIDEO_VID_576I			0x0003
> +#define PS3AV_CMD_VIDEO_VID_480P			0x0005
> +#define PS3AV_CMD_VIDEO_VID_576P			0x0006
> +#define PS3AV_CMD_VIDEO_VID_1080I_60HZ			0x0007
> +#define PS3AV_CMD_VIDEO_VID_1080I_50HZ			0x0008
> +#define PS3AV_CMD_VIDEO_VID_720P_60HZ			0x0009
> +#define PS3AV_CMD_VIDEO_VID_720P_50HZ			0x000a
> +#define PS3AV_CMD_VIDEO_VID_1080P_60HZ			0x000b
> +#define PS3AV_CMD_VIDEO_VID_1080P_50HZ			0x000c
> +#define PS3AV_CMD_VIDEO_VID_WXGA			0x000d
> +#define PS3AV_CMD_VIDEO_VID_SXGA			0x000e
> +#define PS3AV_CMD_VIDEO_VID_WUXGA			0x000f
> +#define PS3AV_CMD_VIDEO_VID_480I_A			0x0010
> +/* video_format */
> +#define PS3AV_CMD_VIDEO_FORMAT_BLACK			0x0000
> +#define PS3AV_CMD_VIDEO_FORMAT_ARGB_8BIT		0x0007
> +/* video_order */
> +#define PS3AV_CMD_VIDEO_ORDER_RGB			0x0000
> +#define PS3AV_CMD_VIDEO_ORDER_BGR			0x0001
> +/* video_fmt */
> +#define PS3AV_CMD_VIDEO_FMT_X8R8G8B8			0x0000
> +/* video_out_format */
> +#define PS3AV_CMD_VIDEO_OUT_FORMAT_RGB_12BIT		0x0000
> +/* video_sync */
> +#define PS3AV_CMD_VIDEO_SYNC_VSYNC			0x0001
> +#define PS3AV_CMD_VIDEO_SYNC_CSYNC			0x0004
> +#define PS3AV_CMD_VIDEO_SYNC_HSYNC			0x0010
> +
> +/* for audio module */
> +/* num_of_ch */
> +#define PS3AV_CMD_AUDIO_NUM_OF_CH_2			0x0000
> +#define PS3AV_CMD_AUDIO_NUM_OF_CH_3			0x0001
> +#define PS3AV_CMD_AUDIO_NUM_OF_CH_4			0x0002
> +#define PS3AV_CMD_AUDIO_NUM_OF_CH_5			0x0003
> +#define PS3AV_CMD_AUDIO_NUM_OF_CH_6			0x0004
> +#define PS3AV_CMD_AUDIO_NUM_OF_CH_7			0x0005
> +#define PS3AV_CMD_AUDIO_NUM_OF_CH_8			0x0006
> +/* audio_fs */
> +#define PS3AV_CMD_AUDIO_FS_32K				0x0001
> +#define PS3AV_CMD_AUDIO_FS_44K				0x0002
> +#define PS3AV_CMD_AUDIO_FS_48K				0x0003
> +#define PS3AV_CMD_AUDIO_FS_88K				0x0004
> +#define PS3AV_CMD_AUDIO_FS_96K				0x0005
> +#define PS3AV_CMD_AUDIO_FS_176K				0x0006
> +#define PS3AV_CMD_AUDIO_FS_192K				0x0007
> +/* audio_word_bits */
> +#define PS3AV_CMD_AUDIO_WORD_BITS_16			0x0001
> +#define PS3AV_CMD_AUDIO_WORD_BITS_20			0x0002
> +#define PS3AV_CMD_AUDIO_WORD_BITS_24			0x0003
> +/* audio_format */
> +#define PS3AV_CMD_AUDIO_FORMAT_PCM			0x0001
> +#define PS3AV_CMD_AUDIO_FORMAT_BITSTREAM		0x00ff
> +/* audio_source */
> +#define PS3AV_CMD_AUDIO_SOURCE_SERIAL			0x0000
> +#define PS3AV_CMD_AUDIO_SOURCE_SPDIF			0x0001
> +/* audio_swap */
> +#define PS3AV_CMD_AUDIO_SWAP_0				0x0000
> +#define PS3AV_CMD_AUDIO_SWAP_1				0x0000
> +/* audio_map */
> +#define PS3AV_CMD_AUDIO_MAP_OUTPUT_0			0x0000
> +#define PS3AV_CMD_AUDIO_MAP_OUTPUT_1			0x0001
> +#define PS3AV_CMD_AUDIO_MAP_OUTPUT_2			0x0002
> +#define PS3AV_CMD_AUDIO_MAP_OUTPUT_3			0x0003
> +/* audio_layout */
> +#define PS3AV_CMD_AUDIO_LAYOUT_2CH			0x0000
> +#define PS3AV_CMD_AUDIO_LAYOUT_6CH			0x000b	/* LREClr */
> +#define PS3AV_CMD_AUDIO_LAYOUT_8CH			0x001f	/* LREClrXY */
> +/* audio_downmix */
> +#define PS3AV_CMD_AUDIO_DOWNMIX_PERMITTED		0x0000
> +#define PS3AV_CMD_AUDIO_DOWNMIX_PROHIBITED		0x0001
> +
> +/* audio_port */
> +#define PS3AV_CMD_AUDIO_PORT_HDMI_0			( 1 << 0 )
> +#define PS3AV_CMD_AUDIO_PORT_HDMI_1			( 1 << 1 )
> +#define PS3AV_CMD_AUDIO_PORT_AVMULTI_0			( 1 << 10 )
> +#define PS3AV_CMD_AUDIO_PORT_SPDIF_0			( 1 << 20 )
> +#define PS3AV_CMD_AUDIO_PORT_SPDIF_1			( 1 << 21 )
> +
> +/* audio_ctrl_id */
> +#define PS3AV_CMD_AUDIO_CTRL_ID_DAC_RESET		0x0000
> +#define PS3AV_CMD_AUDIO_CTRL_ID_DAC_DE_EMPHASIS		0x0001
> +#define PS3AV_CMD_AUDIO_CTRL_ID_AVCLK			0x0002
> +/* audio_ctrl_data[0] reset */
> +#define PS3AV_CMD_AUDIO_CTRL_RESET_NEGATE		0x0000
> +#define PS3AV_CMD_AUDIO_CTRL_RESET_ASSERT		0x0001
> +/* audio_ctrl_data[0] de-emphasis */
> +#define PS3AV_CMD_AUDIO_CTRL_DE_EMPHASIS_OFF		0x0000
> +#define PS3AV_CMD_AUDIO_CTRL_DE_EMPHASIS_ON		0x0001
> +/* audio_ctrl_data[0] avclk */
> +#define PS3AV_CMD_AUDIO_CTRL_AVCLK_22			0x0000
> +#define PS3AV_CMD_AUDIO_CTRL_AVCLK_18			0x0001
> +
> +/* av_vid */
> +/* do not use these params directly, use vid_video2av */
> +#define PS3AV_CMD_AV_VID_480I				0x0000
> +#define PS3AV_CMD_AV_VID_480P				0x0001
> +#define PS3AV_CMD_AV_VID_720P_60HZ			0x0002
> +#define PS3AV_CMD_AV_VID_1080I_60HZ			0x0003
> +#define PS3AV_CMD_AV_VID_1080P_60HZ			0x0004
> +#define PS3AV_CMD_AV_VID_576I				0x0005
> +#define PS3AV_CMD_AV_VID_576P				0x0006
> +#define PS3AV_CMD_AV_VID_720P_50HZ			0x0007
> +#define PS3AV_CMD_AV_VID_1080I_50HZ			0x0008
> +#define PS3AV_CMD_AV_VID_1080P_50HZ			0x0009
> +#define PS3AV_CMD_AV_VID_WXGA				0x000a
> +#define PS3AV_CMD_AV_VID_SXGA				0x000b
> +#define PS3AV_CMD_AV_VID_WUXGA				0x000c
> +/* av_cs_out av_cs_in */
> +/* use cs_video2av() */
> +#define PS3AV_CMD_AV_CS_RGB_8				0x0000
> +#define PS3AV_CMD_AV_CS_YUV444_8			0x0001
> +#define PS3AV_CMD_AV_CS_YUV422_8			0x0002
> +#define PS3AV_CMD_AV_CS_XVYCC_8				0x0003
> +#define PS3AV_CMD_AV_CS_RGB_10				0x0004
> +#define PS3AV_CMD_AV_CS_YUV444_10			0x0005
> +#define PS3AV_CMD_AV_CS_YUV422_10			0x0006
> +#define PS3AV_CMD_AV_CS_XVYCC_10			0x0007
> +#define PS3AV_CMD_AV_CS_RGB_12				0x0008
> +#define PS3AV_CMD_AV_CS_YUV444_12			0x0009
> +#define PS3AV_CMD_AV_CS_YUV422_12			0x000a
> +#define PS3AV_CMD_AV_CS_XVYCC_12			0x000b
> +#define PS3AV_CMD_AV_CS_8				0x0000
> +#define PS3AV_CMD_AV_CS_10				0x0001
> +#define PS3AV_CMD_AV_CS_12				0x0002
> +/* dither */
> +#define PS3AV_CMD_AV_DITHER_OFF				0x0000
> +#define PS3AV_CMD_AV_DITHER_ON				0x0001
> +#define PS3AV_CMD_AV_DITHER_8BIT			0x0000
> +#define PS3AV_CMD_AV_DITHER_10BIT			0x0002
> +#define PS3AV_CMD_AV_DITHER_12BIT			0x0004
> +/* super_white */
> +#define PS3AV_CMD_AV_SUPER_WHITE_OFF			0x0000
> +#define PS3AV_CMD_AV_SUPER_WHITE_ON			0x0001
> +/* aspect */
> +#define PS3AV_CMD_AV_ASPECT_16_9			0x0000
> +#define PS3AV_CMD_AV_ASPECT_4_3				0x0001
> +/* video_cs_cnv() */
> +#define PS3AV_CMD_VIDEO_CS_RGB				0x0001
> +#define PS3AV_CMD_VIDEO_CS_YUV422			0x0002
> +#define PS3AV_CMD_VIDEO_CS_YUV444			0x0003
> +
> +/* for automode */
> +#define PS3AV_RESBIT_720x480P			0x0003	/* 0x0001 | 0x0002 */
> +#define PS3AV_RESBIT_720x576P			0x0003	/* 0x0001 | 0x0002 */
> +#define PS3AV_RESBIT_1280x720P			0x0004
> +#define PS3AV_RESBIT_1920x1080I			0x0008
> +#define PS3AV_RESBIT_1920x1080P			0x4000
> +#define PS3AV_RES_MASK_60			(PS3AV_RESBIT_720x480P \
> +						| PS3AV_RESBIT_1280x720P \
> +						| PS3AV_RESBIT_1920x1080I \
> +						| PS3AV_RESBIT_1920x1080P)
> +#define PS3AV_RES_MASK_50			(PS3AV_RESBIT_720x576P \
> +						| PS3AV_RESBIT_1280x720P \
> +						| PS3AV_RESBIT_1920x1080I \
> +						| PS3AV_RESBIT_1920x1080P)
> +
> +#define PS3AV_MONITOR_TYPE_HDMI			1	/* HDMI */
> +#define PS3AV_MONITOR_TYPE_DVI			2	/* DVI */
> +#define PS3AV_DEFAULT_HDMI_VID_REG_60		PS3AV_CMD_VIDEO_VID_480P
> +#define PS3AV_DEFAULT_AVMULTI_VID_REG_60	PS3AV_CMD_VIDEO_VID_480I
> +#define PS3AV_DEFAULT_HDMI_VID_REG_50		PS3AV_CMD_VIDEO_VID_576P
> +#define PS3AV_DEFAULT_AVMULTI_VID_REG_50	PS3AV_CMD_VIDEO_VID_576I
> +#define PS3AV_DEFAULT_DVI_VID			PS3AV_CMD_VIDEO_VID_480P
> +
> +#define PS3AV_REGION_60				0x01
> +#define PS3AV_REGION_50				0x02
> +#define PS3AV_REGION_RGB			0x10
> +
> +#define get_status(buf)				(((__u32 *)buf)[2])
> +#define PS3AV_HDR_SIZE				4	/* version + size */
> +
> +/* for video mode */
> +#define PS3AV_MODE_MASK				0x000F
> +#define PS3AV_MODE_HDCP_OFF			0x1000	/* Retail PS3 product doesn't support this */
> +#define PS3AV_MODE_DITHER			0x0800
> +#define PS3AV_MODE_FULL				0x0080
> +#define PS3AV_MODE_DVI				0x0040
> +#define PS3AV_MODE_RGB				0x0020
> +
> +#ifdef __KERNEL__

If the definitions below are kernel-only, does that mean you want everything above
to be exported to user space? Is that necessary?

> +struct ps3av {
> +	int available;
> +	struct semaphore sem;

The semaphore should most likely be a 'struct mutex' instead.

	Arnd <><
