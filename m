Message-ID: <3E748DFF.5070607@tataelxsi.co.in>
Date: Sun, 16 Mar 2003 20:15:19 +0530
From: "Omanakuttan" <omanakuttan@tataelxsi.co.in>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org, omanakuttan@vsnl.net
Subject: linux mpc8260 mcc programming howto
Content-Type: multipart/mixed;
 boundary="------------060106000005000404020100"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------060106000005000404020100
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,
I have created a how to on mpc8260 mcc programming. I am attaching it
along with this mail. I hope this will be useful for any rookies who
wants to start programming MCC on linux. I intend to publish this as a
howto as soon as I can format it in SGML. :-)

Any suggestion and corrections are welcome.
Please send them to omanakuttan@vsnl.net

Thank you,
Om.

--------------060106000005000404020100
Content-Type: text/plain;
 name="mpc8260mcc_howto.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mpc8260mcc_howto.txt"

/*
 * $Log: mpc8260mcc_howto.txt,v $
 * Revision 1.8  2003/03/16 19:58:44  om
 * final version
 */
MPC8260 MCC programming HOWTO

copyright (c) 2003 Omanakuttan.N.
(omanakuttan at vsnl dot net)

Abstract:
This document attempts to give the linux developer community of motorola(R)'s
mpc8260 processor a fairly good idea of programming details of Multi
Channel controller.
This document can be distributed under GPL version 2.0 or later, GPL is
available at (http://www.gnu.org/copyleft/gpl.html)

Table of contents:
1.  Introduction.
2.  Different controllers of MPC8260
3.  Different Data structures used in the mcc programming model.
    3.1 Global parameters
    3.2 Channel extra parameters
    3.3 Super channel tables
    3.4 Channel specific HDLC parameters
    3.5 SIxRAM
    3.6 Interrupt vector table
    3.7 Buffer descriptor table
    3.8 Dual port RAM
4.  Programming MCC
    4.1 Initialization sequence
    4.2 Opening/Enabling a channel
    4.3 Closing/Disabling a channel.
    4.4 How the interrupts should be handled
5. Conclusion
6. Appendices.
    6.1 E1 Framing format.
    6.2 T1 Framing format.
    6.3 How does kmalloc always return contiguous addresses
7. Credits


1. Introduction
    mpc8260 powerquicc II(TM) is a versatile 32 bit communications processor
    based on the RISC architecture. The core processing unit is an embedded
    variant of PowerPC 603e. This features 16kBytes instruction cache as well
    as 16kBytes of data cache. In a communication processor, since very few
    (practically nil) floating point operations takes place, there is no
    FPU.

2.  Different controllers of mpc8260.

    Multi channel controller.
    The Multi channel controller controls the channelization as well as
    multiplexing of the data. The requirement of channelized data arises where
    the communication channels such as E1 or T1 (see appendix 7.1 and 7.2) are
    to be handled. Mcc helps to demultiplex and multiplex the individual
    communication channels.

    There are 2 MCCs in the MPC8260 Microprocessor. Each of them is capable
    of handling up to 128 different 64kbps channels. All these 128 channels
    share the global data for that particular MCC. MCC global data is not
    shared across MCCS. Multichannel controller can work either in HDLC mode
    or Transparent mode

    There are other serial controllers in mpc8260 which handles non
    channelized data such as ethernet, ATM ... etc known as Fast communication
    controller. There are 3 FCCs available in mpc8260. Another serial
    controller is Serial communication controller and Serial management
    controller.

3. Data structures used the MPC8260 Microprocessor MCC programming model.

    Before proceeding any further, some fundamentals are to be made clear.
    I will briefly explain the essentials. This explanation is by no means
    complete. Please consult the MPC8260 Microprocessor manual for more
    details.

    3.1 Each MCC global data structure (called global parameter) is of
        128 bytes. Global parameter of MCC1 starts from 0x8700 offset of
        DPRAM, whereas that of MCC2 starts from 0x8800. Each of them is of
        size 128 bytes, out of which 100 bytes are only used (offset
        0x63).  The important variables of global parameters are
        mccbase     :
            This is the base address (physical) of the buffer descriptor
            table. This should be initialized by the user (driver code).
        mccstate    :
            This is reserved for the user. User should initialize this value to
            zero when the driver starts.
        mrblr       :
            This defines the maximum number of bytes written to a receive buffer
            before moving to another buffer. This has to be a multiple of 8.
        grfcnt and grfthr :
            These values define the interrupt frequency. Global receive count is
            set to grfthr initially. Whenever a frame is received, the grfcnt is
            decremented. When the grfcnt reaches 0, a receive interrupt is
            generated and grfcnt is updated with the value of grfthr.
        tintbase  and tintptr  :
            This value is the physical address of the starting of transmit
            interrupt vector table. When driver initializes, this value must be
            copied to tintptr.
        sctpbase    :
            Base address of the super channel table (Explained in section 3.3).
        xtrabase    :
            Extra parameter table information. Explained in section 3.2)
        rinttmpX and rintbaseX :
            There are 4 separate receive interrupt queues for MCC. Any channel
            can join any of any of these interrupt vector queues by specifying
            the appropriate base pointer in the channel specific parameters.
    3.2 Channel extra parameters

        Each channel must be associated with the corresponding buffer
        descriptors it uses for transmission and reception. Channel extra
        parameters stores the address of TxBD and RxBDs. Current position of
        updating of the TxBD and RxBDs are also maintained in the channel extra
        parameters. These values are read only while the channel is enabled.

        Channel extra parameters also resides in the DPRAM. They must start at
        the fixed address => DPRAM address + xtrabase + 8 * channel number.
        At the time of opening (enabling) a channel, tbptr should point to tbase
        and rbptr should point to rbase. Each time a channel is opening
        (enabling), this must be set. This might entail flushing all the buffers
        when the channel is closed. The rx buffers might need to be filled with
        new buffers when the channel is closed.

    3.3 Super channel table
        3.3.1   What is super channel?
            Definition by motorola in one of their tutorials : A super channel
            is multiple DS0s but not a full T1 frame. I will define it as
            follows :
            Sometimes, applications need to use virtual channels of bandwidth
            more than 64kbps (one time slot). For that purpose, there must be
            a mechanism to multiplex more than one virtual channel into one.
            Super channel table provides this facility. This is not limited
            to T1, but also extends to E1 frames as well.
            The allocation of super channels is done in the SIxRAM. (section
            3.5). For HDLC, Super channels are present only in Transmit
            path. In receive path we need not define any super channels. They
            can be programmed to normal channels pointing to same virtual
            channel. (In the documentation mpc8260um.pdf, MCC channel stands
            for virtual channel). This method has the implicit benefit of
            lowering CP load by allocating more fifo space.  In transparent
            mode, receive channels requiring slot synchronization must be
            defined as super channels.

        3.3.2   Super channel table structure
            Super channel table is an array of u16 (ushort). Bits 0 and 1 are
            zeroed out. bits 2 to 9 contains the channel number to which the
            data should be directed. The logical data flow can be summarized as
            follows,
            data from interface -> TDM -> SIxRAM -> SCT -> MCC channel -> app.

        3.3.3   Programming super channel table
            Super channel table must be defined in the DPRAM at offset SCTPBASE,
            in the global parameter. Both MCCs can share same SCTPBASE address.
            Since the SCT indexing is based on virtual channels, there will be
            no collision of index for MCC1 and MCC2.

            For any virtual channel, the SCT index is calculated as
                u16 * sct = DPRAM_BASE + MCCx_global_param->sctpbase ;
                      sct[2 * virtual_channel_number] = channel_num << 6 ;
            Please look in SIxRAM programming in section 3.5 also.

    3.4 Channel specific HDLC parameters.
        The following are the important and need some special discussion I
        think.
        tstate :
            This is the transmitter's internal state. The user has to
            write 0xHH80_0000 into this register in order to start the
            transmission of data.
            HH contains the SDMA channel access parameters. When channel is
            active, CP changes the values of the last 3 bytes, so any read
            should mask 3 LSBs.
            Setting the GBL will enable snooping on 60x bus.
            In the 60x bus there can be more than one bus masters, e.g.,
            cpm, SDMA and core. if snooping is enabled, all the cache
            access will be immediately written to the memory making
            data access consistent.
            HH represents the MSB of TSTATE. In this 5th bit is known as
            TC2 ( Transfer Code 2). By having a value different from
            SCC/FCC, MCC performance may be better. So if FCC uses TC2
            equal to 1, put 0 here and vice versa.
        zistate :
            This is the zero insertion machine state. This is called
            bit-stuffing machine state.
            (http://ltl13.exp.sis.pitt.edu/WebSite/Glossary/Letters/Z.htm)
        zidata0 and zidata1 :
            must be initialized to 0xFFFF_FFFF
        intmask :
            This value is the interrupt mask of the channel. To enable an
            interrupt, set the corresponding bit. Reserved bits must be
            cleared before enabling interrupts.
        chamr   :
            This is the value of the channel mode register. The bits are
            described as :
            0 : Mode -- Decides the mode of operation of this channel. A
                value of 0 -> Transparent mode, 1 -> HDLC mode.
            1 : POL -- Enabling polling. Polling helps to optimize the use
                of external bus. Whenever there are no more buffers to
                transmit, CP sets the polling to 0. So to minimize useless
                transactions, software should ideally prepare BDs first,
                set Ready bit of the BDs, then enable polling of that
                channel.
            2 : This bit must be set to 1.
            3 : Idle mode -- A value of 0 means that no idle patters are
                to be sent between frames.
                A value of 1 means that at least one idle pattern has to
                be sent between frames.
            4-7 : Reserved bits and must be cleared.
            8 : CRC -- selects between 16 and 32 bit CRCs
            9 : Reserved bit and must be cleared
            10 : TS -- Time stamp option. If this bit is 1, a 4 byte time
                stamp is written at the beginning of the buffer, and the
                buffer must begin at address 8 x n - 4, where n is any
                positive integer.
            11-12: RQN -- Receive queue number. Remember channel can join
                any one of the four interrupt queues. This value determines
                the queue in which this channel is a member.
            13-15: NOF -- Minimum umber of flags to be sent before frames
        rstate :
            Internal receiver status. To start a channel user should write
            0xHH80_0000 into this register.
            This is similar to the TSTATE register. The 7th bit indicates
            BD as well as the interrupt circular tables.
            The Rx BDs of all channels that uses a particular interrupt
            table must reside on the same bus. All TxBDs must reside on
            the same bus.
        mflr :
            This value is the maximum frame length, i.e, the longest frame
            expected for that channel. Whenever a frame is received which
            is larger than mflr, the remainder of the frame larger than
            mflr is discarded. Along with MCC will set the LG flag in the
            last BD.
    3.5 SIxRAM
        Using the two Serial Interfaces, mpc8260 can be programmed to
        handle eight TDM channels simultaneously. Channels on SI1 are
        known as TDMa1, TDMb1, TDMc1, TDMd1 and those on SI2 are known as
        TDMa2, TDMb2, TDMc2, TDMd2. For an Multi Channel Controller (MCC)
        route, SI can be used for arbitrary mapping of Time slots,
        independent mapping of Rx and Tx ..etc.
        Important thing to notice is that TSA programming is independent
        of the controller and thus protocol used. TSA simply routes the
        programmed portions of the data frame from the TDM pins to the
        target controller. Actual protocol handling is done in the
        controller.
        For a detailed discussion of TSA configurations, please refer
        mpc8260um.pdf 14-5.
        Total SIxRam is divided into SI1Tx Routing RAM, SI1 Rx Routing
        RAM, SI1Tx Routing RAM and SI1 Rx Routing RAM each of 256 x 16
        bits. Each Routing RAM is divided into banks of 32x16 bits each.
        All these SIxRAMs are directly accessible  by the core and are
        _NOT_ a part of DPRAM.
        Not all of the entries of SIxRAM is always used. The actual number
        of entries used always depend on the frame that user expects.
        For example, when we programmed E1 lines routing on SIxRAM we used
        all the 32 entries per bank. Wherein T1 lines routing on SIxRAM, we
        used only 24 of them.
        SIxRAM entries are unset after power reset. User must program SIxRAM
        entries before enabling TDMs.

        Static routing and dynamic routing of SIxRAM.
            In each SI, 2 banks of 32 entries are available for programming
            the the routing of data. One of them can act as a shadow SIxRAM
            This is useful when dynamic change of routing decisions are
            required. I have not used dynamic routing, so that I am unable
            to throw any more light on this. Please consult mpc8260um.pdf,
            page 14-8 through 14-10
            If no dynamic routing is required, all the banks can be
            programmed for routing of data. Dynamic routing reduces the
            number of entries available for data routing.

        3.5.1   SIxRAM Programming for MCC
            While programming for an MCC, SIxRAM entries will have MCC bit
            set (i.e, bit 0) The rest of the bit settings can be
            bit 1 : LOOP/ECHO -- If value is 0,  that means it is normal
                    mode of operation
            bit 2 : SUPER -- If value is 0, this time slot is not a super
                    channel, else this time slot is a super channel.
            bit 3-10 : Value of these bits indicates the channel to which
                    the bit/byte should route to.
            bit 11-13 : CNT -- Value of this, along with the BYT bit,
                    indicates the number of bytes/bits routed by this entry
                    of the SIxRAM.
                    if SUPER is 0, one bit/byte (according to BYT entry) is
                    routed.
                    if SUPER = 1,
                        if BYT = 1, and CNT = 000 then current entry is the
                        first byte of this MCC super channel.
                        if BYT = 0 and CNT = 111, then current entry is not
                        the first byte of the MCC super channel.
                    No other combination of these values or no other values
                    for CNT are valid for super channels.
            Please refer section 6.1 and 6.2 also.

        3.5.2   SIx Mode register programming
            There are 8 SI mode registers, one each for defining SI
            operations. One important thing while programming SIMR is that
            even though user can put the shadow RAM section of the same TDM
            on the same bank, user cannot put two different TDMs on the same
            bank. So a configuration like
            TDMa --> 0-31 (bank 1, first 32)
            TDMb --> 32-63 (bank 1, second 32)
            TDMc --> 64-95 (bank 2, first 32) ...etc is _NOT_ allowed.
            One field of importance is RFSDx. This is used for introducing
            delays to synchronize packets. We used this bit to discard one bit
            (starting bit of T1 frame) which we did not require.

    3.6 Interrupt vector table.
        MPC8260 MCC's interrupt processing is handled by 5 interrupt vector
        tables. All of them are circular tables. That means once the end of
        the IVT is met, then the processing will happen from the beginning.
        Thus the size of IVT is not fixed by length, but a bit in the IVT entry.
        The ivt entry has the following structure.

        Bit 0           -> Valid bit
        Bit 1           -> Wrap bit.
        Bits 2-17       -> Interrupt flags. (more on this follows)
        Bits 18-25      -> Channel Number (more on this follows)
        Bits 26-31      -> Unused.

        The interrupt vector table will be an array of data type u32 in the
        linux kernel. While setting up MCC, same IVT can be used by both MCCs.
        But Receive IVTs and Transmit IVTs cannot be interchanged in different
        MCCs.

        Setting up IVTs:
        Declare an array of u32s of some size depending upon your need. Set
        all the elements to 1<<31. This sets the valid bit in all entries. In
        the last entry, set wrap bit to 1.
        There are different error values associated with each IVT entry. These
        are set by CP on interrupts. User is not supposed to set any of these
        values. All must be 0.
        On an interrupt, immediately after reading the value of the IVT entry,
        user must clear all bits except wrap bit. Also user must set the valid
        bit to 1, so that CP can use that interrupt entry. As long as valid
        bit is 0, CP will not modify the contents of that particular IVT
        entry.
        Out of the 4 Receive interrupt IVTs, user is free to choose the number
        of IVTs for receive data. The number of channels joining a particular
        receive queue is determined by the channel's channel specific
        parameters. All channels can join single Receive queue or different
        channels can join different Receive queues. But no channel can join
        more than one Receive queue.

    3.7 Buffer descriptor table
        To send the data out of MCC or to receive data from outside, MCC uses
        buffers. These buffers are arranged in buffer descriptor tables. These
        BD tables have a common format for all FCCs, SCCs and SMCs. It can be
        found in include/asm-ppc/commproc.h under the definition struct cbd_t.
        Buffer descriptor table (BDT) is an array of struct cbd_t-s.
        This table is also a circular buffer.

        Fields of cbd_t structure.
        cbd_sc      -> flags for status and control of size 2 bytes.
        cbd_datlen  -> length of data associated with this BD.
        cbd_bufaddr -> Address of data associated with this BD.
        IMPORTANT: The address should be a physical address.

        There are separate BDTs for Receive and Transmit. Receive and transmit
        BDTs cannot be multiplexed. I.e, for every channel, there must be
        different transmit and receive BDTs.

        There is one more constraint for BDTs. All BDTs of one particular MCC
        should be within one contiguous chunk of 512kBytes memory. This means
        the user cannot use multiple kmalloc calls to setup BDTs for different
        channels unless the all the malloc calls returns address within one
        512kB memory. Instead allocate all BDTs in one single kmalloc and
        partition the contiguous area into multiple BDTs, by setting Wrap bit
        on appropriate cbd_t elements. All BDTs need not be of same length.

        For setting up the receive BDT, first allocate buffers which will hold
        the actual data for all the receive BDT entries. Once the data buffer
        is allocated, attach the buffer with the BDT entry by filling in the
        address and data length fields in the BD. Then set up the status and
        control flags.

        Even though receive BDTs and transmit BDTs are allocated together and
        have same structure, the control flags and status flags can differ.
        In receive BDTs, control and status flags have 4 user filled bits. Out
        of that, on setting up BDT, Empty bit is filled for all entries with 1
        to indicate that the buffer is ready to receive data.
        One question is how and when to allocate the buffer descriptor tables.
        One of the drivers I have seen is allocating all the buffers as well as
        the buffer descriptor tables statically. In the driver I wrote, I
        allocate the BDTable statically, whereas the allocation of the receive
        buffers are dynamic. Any of these approaches are valid and both are
        right.

        Whenever Buffer Descriptors are allocated, care must be taken to ensure
        that each MCC gets at least two BD tables, one for transmit and one for
        receive. BDs can be dynamically added and removed from a BD table by
        manipulating the wrap bit.  The last entry of the BD table is decided
        by the wrap bit of the BD.  The RxBD should contain at least 2 Buffer
        Descriptors and Rx BD table should contain at least 1 Buffer
        Descriptor.  Unlike FCC / SCC, MCC Buffer Descriptors are located in
        the external memory.

        While allocating Receive buffers, one point to notice is that one
        should allocate MFLR + 8 bytes of data. The reason for this is to
        accommodate a particular error condition known as NO aligned data
        reception. In this case, a frame of bits which is not exactly
        divisible by 8 has been received by MCC.For details refer section 4.4 and
        mpc8260um.pdf page 27-22.

        Some points to note in Rx Buffer descriptors:

            Data length is the number of bytes written to this BD's data
            buffer by CP, when the buffer is closed. If the BD is the last one
            in the frame, the CRC is written into. The CRC length may be 16 or
            32 bits depending on the CRC selection. If the BD is not last one,
            data length will be unset.(is it so?)

            Rx buffer pointer : The Rx buffer pointer should point to the
            first location of the data. This must be a physical address. The
            value of data pointer must be,
                8 * n if time stamp is disabled in the channel specific
                parameter of that particular channel.
                8 * n-4 if time stamp option is disabled in the channel
                specific parameter of that particular channel.

        Some points to note in Tx Buffer descriptors:

            Data length is the number of bytes MCC should transmit from this
            BD. This value is never modified by CP.
            Tx buffer pointer is the physical address of the data. This can be
            odd or even. Buffer may reside in either external or internal
            memory. CP does not modify this value.

    3.8 Dual port RAM --DPRAM
        MPC8260 CPM ( communication processor module) has 24kB of static RAM,
        with a 64 bit wide data bus. This is called DPRAM. The main use of DPRAM is
        a.  To store parameters associated with Fast Communication Controller
            (FCC), Multi Channel Controller (MCC), Serial Communication
            Controller (SCC), IDMA  and the like.
        b.  To store Buffer Descriptors.
        c.  For temporary storage of data from Fast Communication Controller
            (FCC) fifo to external memory by SDMA

        DPRAM is devided into banks of 2kb each.
        There is a feature of DPRAM allows motorola to store the microcode for
        the Communication Processor module in the DPRAM. Actually this give
        rise to an incompatibility of making the banks unusable for
        programming parameters with static addresses such as MCC channels. If
        the microcode is loaded in a bank, it cannot be used for any other
        purposes.

        DPRAM banks are divided into 3 parts.
        0x0 to 0x3fff addresses can contain either Buffer Descriptors, data or
        uCode supplied by motorola.
        0x4000 to 0x7fff is reserved and not considered as DPRAM.
        0x8000 to  0x8fff is called parameter RAM.
        0x9000 to 0xa777 is reserved.
        0xb000 to 0xbfff is used for FCC data.

        Parameter RAM : Contains Serial Communication Controller
        (SCC) parameters, Multi Channel Controller (MCC) parameters, Fast
        Communication Controller (FCC) parameters ..etc. For a detailed list
        of parameter RAM contents, please see mpc8260um.pdf page 13-19.

4.  Programming MCC
    While I wanted to write a device driver for MCC, I had no sample
    code/knowledge to help me in writing this. After a few weeks of research and
    mailing to motorola and going through lists archives, I came up with the
    following sequence.

    4.1 Initialization sequence.
        In the module_init, the sequence of operations are as follows.
        Important :
        To access the memory locations pointed by the immap_t structure, no need
        of converting the physical address to virtual address. These addresses
        are 1:1 mapped to the physical address.

        Get the global parameter table addresses.

        Initialize the interrupt vector tables, both Tx and Rx if you are using
        them. Set up the IVTs with valid entry bits set. Do not do a memset for
        this purpose since memset takes a char argument and not a long argument.
        So a memset(ivt, 0x80000000, sizeof(ivt)) may not produce the desired
        effect. Set the last entry with wrap bit.

        Initialize the global parameters, for both MCC1 and MCC2. tintbase and
        rintbase_X should be filled in with physical addresses. So is the
        mccbase.

        Initialize the Rx buffers. Allocate them if necessary. While allocating
        buffers, take care to allocate space for Time stamp and NonOctet aligned
        frame error if necessary. Attach them to BDs. Set the status/control
        flags to proper values. Set the maximum receive buffer length to MRBLR.
        This can be different from allocated space. Fill in the physical address
        of the memory buffer into BD pointer.

        Initialize the SIxRAM. Clear the SIxRAM by memset()-ing it. For Rx SIxRAM
        entries, no special treatment is required if HDLC mode is used. We were
        using HDLC and I have not much idea about Transparent mode. Each Rx
        SIxRAM entry should point to the channel. For Tx, if super channels are
        required, super channel table must be created and programmed accordingly
        It is not required that SCT must be programmed first.

        Initialize the si global mode resiters.

        Set up the MCCF and MCCM registers.

        Set up extra base parameters.

        Set up channel specific parameters.

        Issue a reset for all channels, after stopping them.

        Enable interrupts.

        Setup clock route registers

    4.2 Opening a channel.
        Get the pointer to channel specific parameters.
        Reset the zistate and zdstate to default values.
        Reset the zidata and zddata to zero.
        Issue 0xHH800000 to rstate and tstate, with proper values for HH.

    4.3 Closing a channel.
        Ensure that there is no other command waiting for completion on cpcr.
        Issue a stop command for Rx and Tx of the channel.
        There can be a a race condition in which the ISR updates MCC command
        before the close command is completed. Take care of such things in
        your code, either by using spin locks or waiting for completion in
        both ISR and closing function.
        No need of clearing tstate and rstate registers after issuing stop
        command.

    4.4 Interrupt handling.
        The MCC interrupt handling can be a little tricky with
        synchronization issues if both MCCs are used. In the ISR top half,
        we just saved mcce registers of both MCCs and scheduled a tasklet to
        handle the rest of the processing.
        The following events can generate interrupts depending on the mask
        bits.

        Global Tx Under run. MCC's FIFO faced an under run. No way to find out
        which of are the channels affected. MCC must restart.
        Global Rx overrun. MCC's FIFO faced overrun. No way to find out which
        of the channels are affected. MCC must restart
        The handling of GOV or GUN involves the restart of the MCC affected.
        The procedure for restart of one MCC is,
            Disable the TDMs for that MCC by programming global mode
            registers.
            Issue the MCC reset command to the cpcr.
            Wait until the command is carried out. This approach will
            eliminate the race condition described earlier, as well as any
            possibility of accessing the cpcr before completion of any of the
            other controller's command completion.
            Issue init txrx command to cpcr and wait until the command is
            carried out for all the channels in that MCC.
            Reset zistate and zidata of all the channels in that MCC
            Reset zdstate and zddata of all the channels in that MCC
            If any of the global parameters are to be changed, change them.
            Reinitialize buffer descriptors of all the channels associated
            with this MCC
            Enable the TDMs for this MCC

        Addition of at least one entry into the receive interrupt vector table.
        CP tries to update an IVT entry not handled by the user (i.e, v bit =
        1)
        Addition of at least one entry into the transmit IVT.
        Important : The tx and rx handling routines should take care of the
        circular nature of the BD Table as well as IVTs.

        Handling of RINT
            Find out the queue in which the RINT occurred, only that queue
            need to be handled.
            There can be more than one entries to be handled in the RINT queue.
            So the Rx handling routine should examine all of the entries until
            it sees v=0 in the ivt entry.
            If there are no entries with valid bit set, handler can
            immediately exit.
            If a valid entry is found, save the value and clear the entry.
            Find out the MCC channel which received the frame. In the channel,
            there can be more than one frame received. Start a loop examines
            buffer descriptors until it comes across a BD with empty bit set.
            Depending on the application, the received buffer can be copied or
            directly sent to the upper layers for processing. One thing to
            notice here is the Buffer Descriptors contain the physical address
            of the buffer and this must be converted to virtual address for
            accessing this buffer.
            A couple of errors can happen while receiving buffers. They are
            captured in the BD flags.
            In HDLC mode, if 10th bit of the BD flags is set, indicates that
            a frame whose length is greater than MFLR is received. Only the
            MFLR rounded off to the next higher word alignment is written onto
            the buffer. The rest is discarded and when a flag is received, the
            buffer is closed, LG is set and interrupt is generated. Length
            field of this buffer will show the actual length ( flag to flag)
            in octets.
            If the 11th bit of the BD flags is set, indicates that a frame
            whose number of bits is not exactly divisible by 8 is received. To
            accommodate this extra byte, always allocate MFLR + 8 bytes in
            each buffer.

        Handling of TINT
            Since there is only one TINT queue, no need of searching the
            queues here :-)
            Similar to Rx handling, there can be more than one entries to be
            handled in TINT queue. The handling routine should examine all of
            the entries until it sees v=0 in IVT entry. If there is no valid
            entry, then handler can exit.
            After saving the valid entry, handler clears the entry in ivt. The
            channel is found out from the saved value. The corresponding
            BDTable is searched for transmitted frames. Depending on the
            application, it can be reused, cleared or freed.

5.  Conclusion
    I have attempted to throw some light on programming MCC on mpc8260. The
    reason I wrote this document is that when I started to program MCC, I
    could not find any document describes how to program it. I was new to
    embedded world and processors.
    I hope this will be useful to rookies who attempts programming mpc8260
    MCC.

6. Appendices
    6.1 E1 framing format and corresponding SIxRAM programming.
        We used MCC for E1/T1 frames processing. This appendix will thow light
        to some of the problems we faced. This is not intended to be a
        detailed discussion of G6xx, G7xx standards.

        One E1 channel consists of 30 or 31 data channels of 64 kbps each and
        one channel for synchronization purpose.  Always the TS0 (Time slot 0)
        will contain the synchronization information from framer to framer. TS
        16 can carry PCM data as well as Signalling information. So in each E1
        frame, 30 or 31 time slots are available for data transfer.

        In any data stream, E1 frame type will alternate between FAS E1 frame
        and non-FAS E1 frame, (Frame alignment signaling). The TS0 of a FAS E1
        frame contain a framing alignment pattern (X1101100: X-> bit for
        international bit). This pattern is used by the remote framer for
        alignmnet pupose. The international bit is used for CRC. In non-FAS
        frame, the international bit is used for multi frame alignment purpose.
        Bit 1 is always 1, and bit 2 is used for yellow alarm. (yellow alarm
        is a condition in which one end detects an Loss of Signal or Loss of
        Frame condition in the incoming data stream). Whenever these
        conditions arise, this bit is set to 1 in all outgoing non-FAS frames

        Every E1 frame is of 8bits/Time slot x 32 time slots = 256 bits.
        When we program SIxRAM for Tx/Rx of E1 channel, we require 32 entries
        per E1 channel. In our case, TS0 was to be discarded and TS16
        contained PCM data. This was achieved by programming each SIxRAM entry
        corresponding to TS0 with zeros, including the MCC field of this
        SIxRAM entry. If an SIxRAM entry is 0, the data is ignored for that
        TS by the corresponding serial controller.
        Since we were not processing the individual time slots we required a
        super channel of 31 MCC channels. So we programmed the entry
        corresponding to TS1 with SUPER = 1, CNT = 001 and BYT = 1, TS2 to
        TS31 with SUPER = 1, CNT = 111 and BYT = 0 on the transmit side. On
        the receive side, we did not require super channels. On receive side,
        we skipped the initial 8 bytes, routed the TS1-TS31 to one MCC
        channel.

    6.2 T1 Framing format and corresponding SIxRAM programming.
        One T1 channel consists of 24 data channels of 64 kbps each. There is
        no special channel for synchronization/signaling purpose. Such
        information is contained in the frame itself.

        One T1 frame will contain 24 Timeslots of 8 bits each + one bit for
        signaling / synchronization purpose, giving a frame size of 193
        bits/frame. The first bit of a T1 frame is called S-bit.
        (Since we did not have any signaling processing, we skipped
        the first bit of all T1 frames. The rest 192 bits formed a super
        channel for us. To handle them, 24 entries were programmed in the
        SIxRAM as super channels on the transmit side. On receive side, one
        bit was skipped and TS1-TS23 were routed to one MCC channel.


    6.3 How does kmalloc return contiguous physical memory?
        One problem we faced while allocating buffers is that the memory must
        be capable of DMA. The Communication Processor does not use linux mm
        and accesses the buffer memory directly. This implies that the
        allocated memory for buffers must be physically contiguous.

        Linux has 3 memory zones. DMA memory is used exclusively for ISA
        devices and does not extend beyond first 1MB of physical memory. The
        rest is normal memory which is allocated using kmalloc. High Memory
        (explain).

        To avoid fragmentation of memory linux memory manager uses buddy
        algorithm. According to this, whole memory is devided into physically
        contiguous pages of size 512, 256, ..., 1. Whenever say 128 pages are
        required, then the pool of 128 physically contiguous pages is
        consulted. If the pool has an entry, it is allocated. If not , the
        next higher pool is checked and so on until one free entry is found.
        Upon finding one entry from the higher pool, say 512 pages, 128 pages
        are allocated, the rest 384 pages are divided into 256+128 and entered
        into pools of 256 and 128.

        For small allocations less than 1 page, slab allocator will take care
        of physically contiguous allocations by allocating slabs of 32, 64,
        128...etc bytes.

7.  Credits.
    motorola support staff, who answers the questions posted to them within no
    time.
    members of ppcembedded mailing list (linuxppc-embedded at lists dot
    linuxppc dot org) who answered my (sometimes foolish) questions.
    Gianfranco Morandi (gianfranco dot morandi at euro-studio dot it) who
    wrote the MCC driver and sent to the mailing list.


--------------060106000005000404020100--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
