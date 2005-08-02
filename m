Return-Path: <va824363@albany.edu>
Received: from smtp.albany.edu (mail1.its.albany.edu [169.226.1.105])
	by ozlabs.org (Postfix) with ESMTP id 2406167D77
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  3 Aug 2005 01:45:18 +1000 (EST)
Message-ID: <53547.198.22.236.230.1122997515.squirrel@198.22.236.230>
In-Reply-To: <20050801123728.62764c7e.kim.phillips@freescale.com>
References: <32704.198.22.236.230.1122651627.squirrel@198.22.236.230>
	<20050729153323.3f2c62ad.kim.phillips@freescale.com>
	<32798.24.92.61.26.1122694772.squirrel@24.92.61.26>
	<20050730183217.3310585b.kim.phillips@freescale.com>
	<33216.24.92.61.26.1122857296.squirrel@24.92.61.26>
	<20050801123728.62764c7e.kim.phillips@freescale.com>
Date: Tue, 2 Aug 2005 11:45:15 -0400 (EDT)
From: "Vikas Aggarwal" <va824363@albany.edu>
To: "Kim Phillips" <kim.phillips@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: mpc8248  SEC -- interrupt handler 'is' invoked
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Kim,
 Code excerpts are at after the TRACE.
TRACE Messages from the test ---------

bash-2.05b# modprobe secmpc8248
bash-2.05b# [K/lib/modules/2.6.10-rc3/kernel/crypto/mpc8248/test
SEC1Open() called, inode 0xc0a564cc, file 0xc024e2f4
 *** Test RNG ***

First ID=21474820 ChannelPointerStatusRegister[0]=0x0:
ChannelPointerStatusRegister[0]=0x7

 ChannelPointerStatusRegister[1]=0x0: ChannelPointerStatusRegister[1]=0x7

 ChannelPointerStatusRegister[2]=0x0: ChannelPointerStatusRegister[2]=0x7

 ChannelPointerStatusRegister[3]=0x0: ChannelPointerStatusRegister[3]=0x7

ProcessRequest(): free channel = 0

RequestToDpd(): req @0x7ffff820 ch1

RequestToDpd(): get entry for opId 0x00001000

RequestToDpd(): VerifyRequest(0x7ffff820, 0xc11b9cf0)

RequestToDpd(): clear DPD 0xc11bb910

RequestToDpd(): converting entry4 4->0xc09ffc5c vikas


RequestToDpd(): set length = 160

DPD header         = 0x40000011

Primary EU/Mode 0x04:00, Secondary EU/Mode 0x00:00, Desc Type 0x01, Snoop
Output Data Mode, Done

DPD ptr:len/ext p0 = 0x00000000:00000000

DPD ptr:len/ext p1 = 0x00000000:00000000

DPD ptr:len/ext p2 = 0x00000000:00000000

DPD ptr:len/ext p3 = 0x00000000:00000000

DPD ptr:len/ext p4 = 0x009ffc5c:000000a0

DPD ptr:len/ext p5 = 0x00000000:00000000

DPD ptr:len/ext p6 = 0x00000000:00000000

RequestToDpd() EndOfFunc: req @0x00000000 ch1

ProcessRequest() endOffunc: free channel = 0


InterruptServiceRoutine()

ProcessingComplete(): IntStatus - 0x0000000000000040

ProcessingComplete():->Controller_MEAR=0x011bb910

 ChannelPointerStatusRegister[0]=0x7: ChannelPointerStatusRegister[0]=0x2007

 ChannelPointerStatusRegister[1]=0x0: ChannelPointerStatusRegister[1]=0x7

 ChannelPointerStatusRegister[2]=0x0: ChannelPointerStatusRegister[2]=0x7

 ChannelPointerStatusRegister[3]=0x0: ChannelPointerStatusRegister[3]=0x7

Unknown

ProcessingComplete Done
 ID1
nfs: server 192.168.2.4 not responding, still trying

nfs: server 192.168.2.4 OK

Request Ti ChannelPointerStatusRegister[0]=0x7:
ChannelPointerStatusRegister[0]=0x2007

 ChannelPointerStatusRegister[1]=0x0: ChannelPointerStatusRegister[1]=0x7

 ChannelPointerStatusRegister[2]=0x0: ChannelPointerStatusRegister[2]=0x7

 ChannelPointerStatusRegister[3]=0x0: ChannelPointerStatusRegister[3]=0x7

testSEC1Close() called

ReleaseChannel(1, taskID=0x     148, lock=1)

bash-2.05b#
------------TRACE COMPLETE ------------------------

This is how i write the address of RNG buffer(sec1_dpd.c.
DPDPTR->fld[i].ptr = virt_to_phys(*(unsigned int *) ((unsigned int)pReq +
pDesc->fld[i].ptrOffset1st));

This is how i write the length of RNG buffer(sec1_dpd.c.
DPDPTR->fld[i].len = *(unsigned int *) ((unsigned int)pReq +
pDesc->fld[i].lenOffset1st);
DPDPTR->nxt_dpd_ptr = 0;

This is how i write the DPD's address?(sec1_request.c).
*(ChannelNextDescriptorRegister[freeChannel]+1) =
dma_map_single(NULL,(volatile void
*)(ChannelAssignments[freeChannel].Dpds[0]),64,DMA_BIDIRECTIONAL);

DPD_TABLE
-----------------------------------------------
/*  DPD_FLD_DETAILS_ENTRY
    Describes where and how a field in a request goes to a field in a DPD
*/
typedef struct
{
    char                    *txt;               /* Description of the
                                                   field within the request
                                                   a NULL indicates the end
                                                   of field entries */
    unsigned int            lenOffset1st;       /* Offset into request
pointer
                                                   for the initial length
field */
    unsigned int            lenOffsetNxt;       /* Offset into request
pointer
                                                   for the next length field
                                                   Used when input points to
                                                   output of the previous
                                                   request */
    unsigned int            ptrOffset1st;       /* Offset into request
pointer
                                                   for the initial data
area */
    unsigned int            extOffset;
    FLD_TYPE                dataType;           /* Data type either:
                                                   a "Read" or "Write"
area */
    BOOLEAN                 (*pFncSize)(unsigned long len); /* Pointer to
                                                    function that checks
                                                    whether the length is
                                                    consistent with the
request */
} DPD_FLD_DETAILS_ENTRY;

/*! \struct DPD_DETAILS_ENTRY
    \brief Describes how a request is broken into a single DPD or a set of
chained
    DPDs
*/
typedef struct DPD_DETAILS_ENTRY
{
    unsigned long           opId;               /* Operation ID for entry */
    char                    *txt;               /* Description of request
                                                   a NULL indicates the end
                                                   of the table */
    unsigned long           sz;                 /* Size of request */
    const unsigned long     *hdrDesc;           /* Descriptor Header */
    unsigned int            lenOffsetBlockLen;  /* Offset into request
pointer
                                                   for total length of
data */
    DPD_FLD_DETAILS_ENTRY   fld[NUM_DPD_FLDS];
} DPD_DETAILS_ENTRY;        /* Each request is enumerated here */

#ifndef offsetof
/*  offsetof(s,m)
    Macro that identifies the byte offset of a field m within a structure s
*/
#define offsetof(s,m)   (size_t)&(((s *)0)->m)
#endif
#define STD_OFFSETS(s,l1,l2,p1,p2)  offsetof(s,l1), offsetof(s,l2),\
                                    offsetof(s,p1), 0
#define EXT_OFFSETS(s,l1,l2,p1,p2)  offsetof(s,l1), offsetof(s,l2),\
                                    offsetof(s,p1), offsetof(s,p2)
#define NULL_PTR_OFFSETS(s,l1,l2)   offsetof(s,l1), offsetof(s,l2), 0, 0
#define ZERO_LEN_OFFSETS(s,p1,p2)   0, 0, offsetof(s,p1), offsetof(s,p2)
#define ALL_ZERO_OFFSETS            0, 0, 0, 0
static char NIL[] = {"NIL"};
DPD_DETAILS_ENTRY DpdDetails[] =
{


    /* DPD_RNG_GROUP */
    {
        DPD_RNG_GROUP, "DPD_RNG_GROUP",
        sizeof(RNG_REQ), RngDesc,
        offsetof(RNG_REQ,rngBytes),
        {
            {NIL,           ALL_ZERO_OFFSETS, Read, NULL},
            {NIL,           ALL_ZERO_OFFSETS, Read, NULL},
            {NIL,           ALL_ZERO_OFFSETS, Read, NULL},
            {NIL,           ALL_ZERO_OFFSETS, Read, NULL},
            {"rngData",    
STD_OFFSETS(RNG_REQ,rngBytes,rngBytes,rngData,rngData), Write,
NULL},
            {NULL, ALL_ZERO_OFFSETS, Read, NULL}
        },
    },
    /* DPD_DES_CBC_GROUP */
    {
----------------------------------
testRNG user-space function-----------
int testRng(int fd)
{
    RNG_REQ rngReq;
    int device=0, status;


    /* RNG test */
    printf("\n*** Test RNG ***\n");

    memset(&rngReq, 0, sizeof(rngReq));
    memset(rngBuf, 0, RNG_TESTSIZE);

    rngReq.opId     = DPD_RNG_GETRN;
    rngReq.rngBytes = RNG_TESTSIZE;
    rngReq.rngData  = rngBuf;


    status = putKmem(fd, "vikas\n\0", &rngReq.rngData, RNG_TESTSIZE);
    if (status)
        return status;

    armCompletion(&rngReq);
    {
        int status1;
        SEC1_STATUS statusReq;
        printf("\nFirst ID=%d\n",statusReq.IdRegister);
        status1 = ioctl(fd, IOCTL_GET_STATUS, (int)&statusReq);
    }
    status = ioctl(fd, IOCTL_PROC_REQ, (int)&rngReq);
    printf("\nID1\n");

    if (status = waitCompletion("testRng(): data extraction test", status,
&rngReq))
    {
        int status1;
        SEC1_STATUS statusReq;
        printf("\nID=%d\n",statusReq.IdRegister);
        status1 = ioctl(fd, IOCTL_GET_STATUS, (int)&statusReq);
        fflush(stdout);

        freeKmem(fd, &rngReq.rngData);
        return status;
    }
    printf("\nID2\n");
    fflush(stdout);

    getKmem(fd, rngBuf, &rngReq.rngData, RNG_TESTSIZE);

    freeKmem(fd, &rngReq.rngData);


    /* check random buffer content for nonzero */
    if (rngBuf[0]) {
        printf("*** Test RNG Data ***\n");
        status = 0;
    } else {
        printf("*** Test RNG Failed ***\n");
        status = -1;
    }

    return status;
}
------------------------------------------------------------------










> On Sun, 31 Jul 2005 20:48:16 -0400 (EDT)
> "Vikas Aggarwal" <va824363@albany.edu> wrote:
>
>> Tried it as u said . No luck :(
>> But something more i noted now in CPSR(channel pointer status
>> register=0x2040)  that before ISR invoked it has 0x0:0x7.
>>
>> After ISR invoked it has 0x7:0x2007 .  The 7 in low bits means
>> channel_error and 2 is at "reserved" bits as per documentation, don't
>> know
>> what that means.
>>
>> I also tried kmalloc with GFP_DMA, for the memory where i create the
>> Descriptor.
>> Please keep giving ideas for debugging this as this is what driving me
>> right now.
>> regards
>> -vikas
>
>
> So you reset the master, then the channel, allocate the RNG descriptor,
> allocate the random data buffer, fill the descriptor with values for an
> RNG request the size of your buffer (filling with the physical address of
> your random data buffer), and submit the descriptor's physical address to
> the FR..
>
> btw, I'm finding it hard to help without seeing sec register transaction
> data, descriptor data, virtual and physical addresses, etc.
>
> Kim
>
